require 'helper'

class AozoraTest < Test::Unit::TestCase
  def test_bocchan
    assert { Aozora.bocchan.size == 100 }
    assert { Aozora.bocchan(10) == '親譲りの無鉄砲で小供' }
  end

  def test_text
    assert { Aozora.text(10) == '親譲りの無鉄砲で小供' }
  end

  def test_lemon
    assert { Aozora.lemon(10) == 'えたいの知れない不吉' }
  end

  def test_lorem_ipsum
    assert { Aozora.lorem_ipsum(20) == 'Lorem ipsum dolor si' }
  end

  def test_to_loop_text_when_size_is_larger_than_the_original_text_size
    lemon_text_size = 4931
    assert { Aozora.lemon(lemon_text_size + 5)[-9..-1] == '行った。えたいの知' }
    assert { Aozora.lemon(10000).size == 10000 }
  end

  TITLES = %w(
    bocchan
    joseito
    kokoro
    lemon
    sanshiro
    lorem_ipsum
    christmas_carol
    happy_prince
  ).to_set

  def test_titles
    assert { Aozora.titles.to_set == TITLES }
  end

  def test_to_respond
    TITLES.each do |title|
      assert { Aozora.respond_to? title }
    end
  end
end
