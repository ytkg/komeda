# Komeda
[![Gem Version](https://badge.fury.io/rb/komeda.svg)](https://badge.fury.io/rb/komeda)
[![ci](https://github.com/ytkg/komeda/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/ytkg/komeda/actions/workflows/ci.yml)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/ytkg/komeda/blob/main/LICENSE.txt)

Komeda's coffee menu data

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
$ bundle add komeda
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
$ gem install komeda
```

## Usage

```ruby
require 'komeda'
```

### Get all menu

```ruby
Komeda.all
#=> [
#     {:name=>"コメダブレンド", :description=>"厳選した豆からじっくり丁寧に抽出したコメダ珈琲店伝統の味　濃厚なフレッシュと砂糖の両方を入れるのがオススメです。"},
#     {:name=>"アメリカン", :description=>"軽くて飲みやすく、コーヒーの旨味を楽しめます。"},
#     ...
#     {:name=>"クルーミーショコラ", :description=>"クリームもスポンジもチョコづくし。\n更にきざみくるみとチョコチップを混ぜ込んだホイップクリームを贅沢にサンド。本商品に使用しているチーズは加熱処理済みです。"},
#     {:name=>"りんごーるタルト", :description=>"さっぱりとしたりんご味のクリームの上にシャキシャキ食感のリンゴ果肉と\n" + "彩り鮮やかなりんごソースをたっぷりのせたオールりんごなデザート。"}
#   ]
```

### Get drink menu

```ruby
Komeda.drinks
#=> [
#     {:name=>"コメダブレンド", :description=>"厳選した豆からじっくり丁寧に抽出したコメダ珈琲店伝統の味　濃厚なフレッシュと砂糖の両方を入れるのがオススメです。"},
#     {:name=>"アメリカン", :description=>"軽くて飲みやすく、コーヒーの旨味を楽しめます。"},
#     ...
#     {:name=>"クリームソーダ　でらたっぷりサイズ", :description=>"でらたっぷり約2倍！クリームソーダをでらたっぷりサイズでお楽しみください。※販売は店舗により異なります。※メロンソーダにメロン果汁は含まれておりません。"},
#     {:name=>"アップルジュース", :description=>"りんごのおいしさをぎゅっと濃縮したさっぱりとした味わいです。"}
#   ]
```

### Get food menu

```ruby
Komeda.foods
#=> [
#     {:name=>"ホットドッグ", :description=>"たっぷりコールスローとパリッとウインナーを特製ドッグパンで挟みました。"},
#     {:name=>"フィッシュフライバーガー", :description=>"タルタルソースとチーズが絶妙にマッチ。\n本商品に使用しているチーズは加熱処理済みです。"},
#     ...
#     {:name=>"ジャーマン（沖縄限定）", :description=>"パリッとジューシーなウインナーとたっぷり野菜。\n※店舗により販売状況が異なります　詳しくは店舗にご確認ください"},
#     {:name=>"手作りたまごドッグ", :description=>"自家製たまごペーストとシャキッとレタスのハーモニーをお楽しみください。"}
#   ]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. When changes reach `main`, tagpr prepares a release pull request that updates the version and changelog. Merging that pull request creates a version tag and triggers the RubyGems release workflow.

### Automated menu updates

The daily menu update workflow also supports manual runs. It creates a pull request when the upstream menu changes and enables GitHub auto-merge for that pull request. The required `merge-ready` check waits for the existing CI workflow and verifies that menu update pull requests change only `config/menus.yaml`. A failing check leaves the pull request open for review. Release pull requests are not auto-merged.

To enable this, create a fine-grained GitHub personal access token restricted to this repository, with **Contents: Read and write** and **Pull requests: Read and write** permissions. Add it as the Actions repository secret `MENU_UPDATE_TOKEN`. Renew the secret before the token expires. Enable GitHub auto-merge for the repository and require the `merge-ready` status check on `main`. The token lets the update pull request trigger CI and lets the merge trigger the existing release preparation workflow.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ytkg/komeda. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ytkg/komeda/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Komeda project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ytkg/komeda/blob/main/CODE_OF_CONDUCT.md).
