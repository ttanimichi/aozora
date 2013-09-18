# -*- coding: utf-8 -*-

require 'test/unit'
require_relative '../lib/aozora/base'

class AozoraTest < Test::Unit::TestCase
  Kokoro100 = "私はその人を常に先生と呼んでいた。"+
    "だからここでもただ先生と書くだけで本名は打ち明けない。"+
    "これは世間を憚かる遠慮というよりも、その方が私にとって"+
    "自然だからである。私はその人の記憶を呼び起すごとに、すぐ「"

  def test_initialize
    target = Aozora.new
    expected = Kokoro100
    assert_equal(expected, target.to_s)
  end

  def test_initialize_length
    target = Aozora.new(:kokoro, 10)
    actual = target.to_s.size
    expected = 10
    assert_equal(expected, actual)
  end

  def test_initialize_title
    actual = Aozora.new(:bocchan, 22).to_s
    expected = "親譲りの無鉄砲で小供の時から損ばかりしている"
    assert_equal(expected, actual)
  end

  def test_initialize_other_titles
    texts = Array.new
    texts << Aozora.new(:hashire_merosu).to_s
    texts << Aozora.new(:joseito).to_s
    texts << Aozora.new(:lemon).to_s
    texts << Aozora.new(:london).to_s
    texts << Aozora.new(:ningen_shikkaku).to_s
    texts << Aozora.new(:pandorano_hako).to_s
    texts << Aozora.new(:sangetsuki).to_s
    texts << Aozora.new(:sanshiro).to_s
    texts << Aozora.new(:viyon).to_s
    texts << Aozora.new(:wagahaiwa_nekodearu).to_s
    texts << Aozora.new(:watashino_kojinshugi).to_s
    texts.each do |t|
      assert_equal 100, t.size
    end
    assert_equal texts.size, texts.uniq.size
  end

  # EOFに到達するとループしてファイルの先頭に戻る
  def test_initialize_loop_eof
    actual = Aozora.new(:lemon,4941).to_s[-20..-1]
    expected = "京極を下って行った。えたいの知れない不吉"
  end
  
  def test_dots
    expected = Kokoro100+"…"
    actual = Aozora.new.dots.to_s
    assert_equal(expected, actual)
  end

  def test_alpha_half_symbol
    actual = Aozora.new(:__TEST_DATA__, 85).alpha(:half).to_s[9..16]
    expected = "ababABAB"
    assert_equal(expected, actual)
  end

  def test_alpha_half_string
    actual = Aozora.new(:__TEST_DATA__, 85).alpha("half").to_s[9..16]
    expected = "ababABAB"
    assert_equal(expected, actual)
  end

  def test_alpha_full_symbol
    actual = Aozora.new(:__TEST_DATA__, 85).alpha(:full).to_s[9..16]
    expected = "ａｂａｂＡＢＡＢ"
    assert_equal(expected, actual)
  end

  def test_alpha_full_string
    actual = Aozora.new(:__TEST_DATA__, 85).alpha("full").to_s[9..16]
    expected = "ａｂａｂＡＢＡＢ"
    assert_equal(expected, actual)
  end

  def test_digit_half_symbol
    actual = Aozora.new(:__TEST_DATA__, 85).digit(:half).to_s[0..8]
    expected = "はたして私0101"
    assert_equal(expected, actual)
  end

  def test_digit_half_string
    actual = Aozora.new(:__TEST_DATA__, 85).digit("half").to_s[0..8]
    expected = "はたして私0101"
    assert_equal(expected, actual)
  end

  def test_digit_full_symbol
    actual = Aozora.new(:__TEST_DATA__, 85).digit(:full).to_s[0..8]
    expected = "はたして私０１０１"
    assert_equal(expected, actual)
  end

  def test_digit_full_string
    actual = Aozora.new(:__TEST_DATA__, 85).digit("full").to_s[0..8]
    expected = "はたして私０１０１"
    assert_equal(expected, actual)
  end

  def test_sign_full_symbol
    actual = Aozora.new(:__TEST_DATA__, 85).sign(:full).to_s[48..49]
    expected = "！＃"
    assert_equal(expected, actual)
  end

  def test_sign_full_string
    actual = Aozora.new(:__TEST_DATA__, 85).sign("full").to_s[48..49]
    expected = "！＃"
    assert_equal(expected, actual)
  end

  def test_sign_half_symbol
    actual = Aozora.new(:__TEST_DATA__, 85).sign(:half).to_s[17..18]
    expected = "!#"
    assert_equal(expected, actual)
  end

  def test_sign_half_string
    actual = Aozora.new(:__TEST_DATA__, 85).sign("half").to_s[17..18]
    expected = "!#"
    assert_equal(expected, actual)
  end

  def test_paragraph
    actual = Aozora.new(:kokoro, 300).paragraph(70).text
    expected = "私はその人を常に先生と呼んでいた。だからここでも"+
      "ただ先生と書くだけで本名は打ち明けない。これは世間を憚かる"+
      "遠慮というよりも、その方が私にとって自然だからである。\n私は"+
      "その人の記憶を呼び起すごとに、すぐ「先生」といいたくなる。"+
      "筆を執っても心持は同じ事である。よそよそしい頭文字などはとても"+
      "使う気にならない。\n私が先生と知り合いになったのは鎌倉である。"+
      "その時私はまだ若々しい書生であった。暑中休暇を利用して海水浴に"+
      "行った友達からぜひ来いという端書を受け取ったので、私は多少の金を"+
      "工面して、出掛ける事にした。\n私は金の工面に二、三日を費やした。"+
      "ところが私が鎌倉に着いて三日と経たないうちに、私を呼び寄せた友達は、"
    assert_equal(expected, actual)
  end

  def test_paragraph_blank_line
    tmp = Aozora.new(:kokoro, 300)
    actual = tmp.paragraph(70,{:blank_line=>true}).text
    expected = "私はその人を常に先生と呼んでいた。だからここでもただ先生"+
      "と書くだけで本名は打ち明けない。これは世間を憚かる遠慮というよりも、"+
      "その方が私にとって自然だからである。\n\n私はその人の記憶を呼び起す"+
      "ごとに、すぐ「先生」といいたくなる。筆を執っても心持は同じ事である。"+
      "よそよそしい頭文字などはとても使う気にならない。\n\n私が先生と知り合い"+
      "になったのは鎌倉である。その時私はまだ若々しい書生であった。暑中休暇を"+
      "利用して海水浴に行った友達からぜひ来いという端書を受け取ったので、私は"+
      "多少の金を工面して、出掛ける事にした。\n\n私は金の工面に二、三日を"+
      "費やした。ところが私が鎌倉に着いて三日と経たないうちに、私を呼び寄せた友達は、"
    assert_equal(expected, actual)
  end

  def test_paragraph_space_head
    actual = Aozora.new(:kokoro, 300).paragraph(70,{:space_head=>true}).text
    expected = "　私はその人を常に先生と呼んでいた。だからここでもただ先生"+
      "と書くだけで本名は打ち明けない。これは世間を憚かる遠慮というよりも、"+
      "その方が私にとって自然だからである。\n　私はその人の記憶を呼び起すご"+
      "とに、すぐ「先生」といいたくなる。筆を執っても心持は同じ事である。よそ"+
      "よそしい頭文字などはとても使う気にならない。\n　私が先生と知り合いにな"+
      "ったのは鎌倉である。その時私はまだ若々しい書生であった。暑中休暇を利用"+
      "して海水浴に行った友達からぜひ来いという端書を受け取ったので、私は多少"+
      "の金を工面して、出掛ける事にした。\n　私は金の工面に二、三日を費やした。"+
      "ところが私が鎌倉に着いて三日と経たないうちに、私を呼び寄せた友達は、"
    assert_equal(expected, actual)
  end

  def test_paragraph_space_head_blank_line
    tmp = Aozora.new(:kokoro, 300)
    actual = tmp.paragraph(70,{:blank_line=>true,:space_head=>true}).text
    expected = "　私はその人を常に先生と呼んでいた。だからここでもただ先生と"+
      "書くだけで本名は打ち明けない。これは世間を憚かる遠慮というよりも、その方が"+
      "私にとって自然だからである。\n\n　私はその人の記憶を呼び起すごとに、すぐ"+
      "「先生」といいたくなる。筆を執っても心持は同じ事である。よそよそしい頭文字"+
      "などはとても使う気にならない。\n\n　私が先生と知り合いになったのは鎌倉であ"+
      "る。その時私はまだ若々しい書生であった。暑中休暇を利用して海水浴に行った友"+
      "達からぜひ来いという端書を受け取ったので、私は多少の金を工面して、出掛ける"+
      "事にした。\n\n　私は金の工面に二、三日を費やした。ところが私が鎌倉に着いて"+
      "三日と経たないうちに、私を呼び寄せた友達は、"
    assert_equal(expected, actual)
  end
end
