# -*- coding: utf-8 -*-

# 
# ダミーテキストを生成するためのクラスです。
# 青空文庫などの著作権フリーな文書をもとに整形された文字列を生成します。
# 
# Authors:: Tsukuru Tanimichi
# Version:: 0.1.0
# Copyright:: MIT License
# License:: 2013 Tsukuru Tanimichi
#
class Aozora

  # テキストの種類として指定できるSymbolのリスト
  TITLES = lambda {
    titles = Array.new
    titles.push :kokoro
    titles.push :bocchan
    titles.push :wagahaiwa_nekodearu
    titles.push :sanshiro
    titles.push :hashire_merosu
    titles.push :pandorano_hako
    titles.push :viyon
    titles.push :joseito
    titles.push :ningen_shikkaku
    titles.push :lemon
    titles.push :sangetsuki
    titles.push :watashino_kojinshugi
    titles.push :london
    titles.push :lorem_ipsum
    titles.push :happy_prince
    titles.push :christmas_carol
    titles.push :__TEST_DATA__ # for test only
    return titles
  }.call

  # 英文のテキストのリスト
  EN_TITLES = lambda {
    en_titles = Array.new
    en_titles.push :lorem_ipsum
    en_titles.push :happy_prince
    en_titles.push :christmas_carol
    return en_titles
  }.call

  #
  # Aozoraクラスのインスタンスを生成する。
  #
  # [title] 使用するテキストの種類を設定する
  # [length] テキストの長さを設定する
  #
  def initialize(title=:kokoro, length=100)
    validate_tilte(title)
    validate_length(length)

    if title.kind_of? Numeric
      title = TITLES[title]
    end
    @text = read_file(title, length)
    @toggles = {:dots => false, :paragraph => false}
    if EN_TITLES.include? title
      @lang = :en
    else
      @lang = :ja
    end
    return self
  end

  #
  # <i>Aozora</i><i>to_s</i>の別名です。
  # 生成されたダミーテキストを文字列として返します。
  #
  def text; to_s end

  #
  # テキストの種類として指定できるSymbolおよび番号の
  # 対応表を標準出力に表示します。
  #
  def self.titles
    titles = String.new
    titles += "+--+-------------------------+\n"
    titles += "| n| symbol                  |\n"
    titles += "+--+-------------------------+\n"
    # __TEST_DATA__.txtを含めない
    (0..(TITLES.size-2)).each do |i| 
      num_s = sprintf("%2d",i)
      sym_s = sprintf("%-25s",TITLES[i].inspect)
      titles += "|#{num_s}|#{sym_s}|\n"
    end
    titles += "+--+-------------------------+\n"
    print titles
  end

  #
  # テキストに含まれるアルファベットを半角や全角に変換します。
  # 引数に:halfまたは"half"を渡すとテキスト内のすべてのアルファベットが半角に変換されます。
  # :fullまたは"full"を渡すと全角に変換されます。
  # 
  # [option] オプションを指定します。:half, "half", :full, "full" のうちいずれかを指定して下さい。
  # 
  def alpha(option)
    case option
    when :half, "half"
      @text.tr!("ａ-ｚ","a-z")
      @text.tr!("Ａ-Ｚ","A-Z")
      return self
    when :full, "full"
      @text.tr!("a-z","ａ-ｚ")
      @text.tr!("A-Z","Ａ-Ｚ")
      return self
    end
    raise 'option must be :half, "half", :full, or "full"'
  end

  #
  # テキストに含まれる数字を半角や全角に変換します。
  # 引数に:halfまたは"half"を渡すとテキスト内のすべての数字が半角に変換されます。
  # :fullまたは"full"を渡すと全角に変換されます。
  # 
  # [option] オプションを指定します。:half, "half", :full, "full" のうちいずれかを指定して下さい。
  # 
  def digit(option)
    case option
    when :half, "half"
      @text.tr!("０-９","0-9")
      return self
    when :full, "full"
      @text.tr!("0-9","０-９")
      return self
    end
    raise 'option must be :half, "half", :full, or "full"'
  end

  #
  # テキストに含まれる記号を半角や全角に変換します。
  # 引数に:halfまたは"half"を渡すとテキスト内のすべての記号が半角に変換されます。
  # :fullまたは"full"を渡すと全角に変換されます。
  # 
  # [option] オプションを指定します。:half, "half", :full, "full" のうちいずれかを指定して下さい。
  # 
  def sign(option)
    full_sign = "！＃＄％＆（）＊＋，ー．／：；＜＝＞？＠［］＾＿｀｛｜｝〜’＼"
    half_sign = "!#\$%&()*+,-./:;<=>?@[]^_`{|}~'\\"
    case option
    when :half, "half"
      @text.tr!(full_sign, half_sign)
      return self
    when :full, "full"
      @text.tr!(half_sign, full_sign)
      return self
    end
    raise 'option must be :half, "half", :full, or "full"'
  end

  # 
  # テキストをパラグラフ化します。
  #
  # [p_length] パラグラフごとのおおまかな文字数を指定します。
  # [options] パラグラフに関するオプションをHashで受け取ります。
  #           {:space_head => true} を渡された場合、パラグラフの冒頭にスペースが入ります。
  #           {:_head => true} を渡された場合、パラグラフの冒頭にスペースが入ります。
  #
  def paragraph(p_length=40, options={})
    # 既にparagraphが実行済みだった場合は何もしない
    return self if @toggles[:paragraph]
    @toggles[:paragraph] = true

    div_paragraph(p_length)

    if options[:space_head]
      if @lang == :en
        @text = "    "+@text
        @text.gsub!(/\n/,"\n    ")
      else
        @text = "　"+@text
        @text.gsub!(/\n/,"\n　")
      end
    end

    if options[:blank_line]
      @text.gsub!(/\n/,"\n\n")
    end

    return self
  end

  #
  # ダミーテキストの末尾に、文章の途中であることを示す「…」を付します。
  #
  def dots
    # 既にdotsが実行済みだった場合は何もしない
    return self if @toggles[:dots]

    @text += "…"
    @toggles[:dots] = true
    return self
  end

  #
  # 生成されたダミーテキストを文字列として返します。
  #
  def to_s; @text.to_s end

  private
  
  def read_file(title, length)
    dir = File.expand_path(File.dirname(__FILE__))
    filename = dir+"/../../data/#{title}.txt"

#    Ruby1.9(Linux)版への回避策。UTF-8を指定する
#    File.open(filename) do |full_sign|
    File.open(filename, "r:utf-8") do |full_sign|
      text = String.new
      loop do
        while (line = full_sign.gets) == nil
          full_sign.seek(0) 
        end
        text += line.chomp
        break if text.size >= length
      end
      return text[0...length]
    end
  end

  def div_paragraph(p_length)
    if not p_length.kind_of? Numeric
      raise "invalid argmument: p_length = #{p_length}"
    end
    if (p_length <= 0) or (p_length >= @text.size)
      raise "invalid argmument: p_length = #{p_length}"
    end
    if @lang == :en
      en_div_paragraph(p_length)      
    else
      ja_div_paragraph(p_length)
    end
    return nil
  end

  def ja_div_paragraph(p_length)
    offset = 0; ptr = 0; prev = 0
    comma = "。"
    loop do
      ptr = @text.index(comma, offset)
      # 一度目の探索で終端に辿り着いた場合
      return if not ptr
      # 一度目の探索でp_lengthを超えた場合
      if p_length <= (ptr - offset)
        @text = @text[0..ptr] + "\n" + @text[(ptr+1)..(-1)]
        offset = ptr+2
        next
      end
      
      loop do
        prev = ptr
        ptr = @text.index(comma, (prev+1))
        return if not ptr

        # offsetからの距離
        ptr_rel  = ptr - offset
        prev_rel = prev - offset

        if ptr_rel >= p_length
          if (p_length - prev_rel) < (ptr_rel - p_length)
            # prevの直後に改行を入れてoffsetを更新
            @text = @text[0..prev] + "\n" + @text[(prev+1)..(-1)]
            offset = prev+2
          else
            # ptrの直後に改行を入れてoffsetを更新
            @text = @text[0..ptr] + "\n" + @text[(ptr+1)..(-1)]
            offset = ptr+2
          end
          break
        end
      end
    end
  end

  def en_div_paragraph(p_length)
    offset = 0; ptr = 0; prev = 0
    comma = "."
    loop do
      ptr = @text.index(comma, offset)
      # 一度目の探索で終端に辿り着いた場合
      return if not ptr
      # 一度目の探索でp_lengthを超えた場合
      if p_length <= (ptr - offset)
        @text = @text[0..ptr] + "\n" + @text[(ptr+1)..(-1)].strip
        offset = ptr+2
        next
      end
      
      loop do
        prev = ptr
        ptr = @text.index(comma, (prev+1))
        return if not ptr

        # offsetからの距離
        ptr_rel  = ptr - offset
        prev_rel = prev - offset

        if ptr_rel >= p_length
          if (p_length - prev_rel) < (ptr_rel - p_length)
            # prevの直後に改行を入れてoffsetを更新
            @text = @text[0..prev] + "\n" + @text[(prev+1)..(-1)].strip
            offset = prev+2
          else
            # ptrの直後に改行を入れてoffsetを更新
            @text = @text[0..ptr] + "\n" + @text[(ptr+1)..(-1)].strip
            offset = ptr+2
          end
          break
        end
      end
    end
  end

  def validate_tilte(title) 
    if title == nil
      raise "invalid argmument: title = nil"
    end

    if title.kind_of? Numeric
      if (title > (TITLES.size - 1)) or (title < 0)
        raise "invalid argmument: title = #{title}"
      end
      return nil
    end
    
    if title.kind_of? Symbol
      TITLES.each do |t|
        return nil if t == title
      end
      raise "invalid argmument: title = #{title}"      
    end

    raise "invalid argmument: title must be Symbol or Numeric" 
  end 

  def validate_length(p_length)
    if p_length == nil
      raise "invalid argmument: length = nil"
    end
    
    if not p_length.kind_of? Numeric 
      raise "invalid argument: length must be Numeric" 
    end

    if p_length < 0
      raise "invalid argmument: length = #{lenght}" 
    end
  end 
end
