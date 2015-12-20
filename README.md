# Aozora

[![Gem Version](https://badge.fury.io/rb/aozora.svg)](http://badge.fury.io/rb/aozora)
[![Build Status](https://travis-ci.org/ttanimichi/aozora.svg)](https://travis-ci.org/ttanimichi/aozora)

Lipsum generator for Japanese.

## Installing

```
$ gem install aozora
```

## Usage

```ruby
require 'aozora'

Aozora.text #=> "親譲りの無鉄砲で小供の時から損ばかりしている。小学校に居る時分学校の二階から飛び降りて一週間ほど腰を抜かした事がある。なぜそんな無闇をしたと聞く人があるかも知れぬ。別段深い理由でもない。新築の二階から"

Aozora.bocchan      #=> "親譲りの無鉄砲で小供の時から損ばかりしている。小学校に居る時分学校の二階から飛び降りて一週間ほど腰を抜かした事がある。なぜそんな無闇をしたと聞く人があるかも知れぬ。別段深い理由でもない。新築の二階から"
Aozora.bocchan.size #=> 100
Aozora.bocchan(10)  #=> "親譲りの無鉄砲で小供"

Aozora.titles #=> ["bocchan", "christmas_carol", "happy_prince", "joseito", "kokoro", "lemon", "lorem_ipsum", "sanshiro"]

Aozora.kokoro     #=> "私はその人を常に先生と呼んでいた。だからここでもただ先生と書くだけで本名は打ち明けない。これは世間を憚かる遠慮というよりも、その方が私にとって自然だからである。私はその人の記憶を呼び起すごとに、すぐ「"
Aozora.kokoro(10) #=> "私はその人を常に先生"
Aozora.lemon      #=> "えたいの知れない不吉な塊が私の心を始終圧えつけていた。焦躁と言おうか、嫌悪と言おうか——酒を飲んだあとに宿酔があるように、酒を毎日飲んでいると宿酔に相当した時期がやって来る。それが来たのだ。これはちょ"
Aozora.joseito    #=> "あさ、眼をさますときの気持は、面白い。かくれんぼのとき、押入れの真っ暗い中に、じっと、しゃがんで隠れていて、突然、でこちゃんに、がらっと襖をあけられ、日の光がどっと来て、でこちゃんに、「見つけた！」と"
Aozora.sanshiro   #=> "うとうととして目がさめると女はいつのまにか、隣のじいさんと話を始めている。このじいさんはたしかに前の前の駅から乗ったいなか者である。発車まぎわに頓狂な声を出して駆け込んで来て、いきなり肌をぬいだと思っ"

Aozora.lorem_ipsum     #=> "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore"
Aozora.christmas_carol #=> "MARLEY was dead: to begin with. There is no doubt whatever about that. The register of his burial wa"
Aozora.happy_prince    #=> "High above the city, on a tall column, stood the statue of the Happy Prince. He was gilded all over "
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
