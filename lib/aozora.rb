require 'aozora/loop_file'

module Aozora
  class << self
    def titles
      @titles ||= Dir["#{data_path}/*"].map {|path| File.basename(path) }
    end

    private

    def generate(title, size)
      LoopFile.open("#{data_path}/#{title}") do |file|
        size.times.map { file.getc }.join
      end
    end

    def data_path
      @data_path ||= File.expand_path('../data', __FILE__)
    end
  end

  titles.each do |title|
    define_singleton_method title do |size = 100|
      generate(title, size)
    end
  end

  singleton_class.send :alias_method, :text, :bocchan
end
