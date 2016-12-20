# FREESOULS.cc

296 Portraits by Joi Ito. Essays by Howard Rheingold, Lawrence Liang,
Cory Doctorow, Yochai Benkler, Isaac Mao and Marko Ahtisaari. With a
Foreword by Lawrence Lessig and a Special Interview with Joi Ito. 72
Crowd-sourced Definitions of What A Freesoul is. 36 Landscapes. 200
pages.
[FREESOULS.cc](http://freesouls.cc)

![Screenshot](img/SCREENSHOT.png)

## Instructions

```sh
gem install jekyll bundler
git clone https://github.com/freesouls-cc/freesouls.cc.git
cd freesouls.cc
bundle install
bundle exec jekyll build
```

Update photo data and templates:

* Copy `config/config-sample.rb` to `config/sample.rb` and add API
  keys.

```sh
bundle exec rake sync
bundle exec rake gen
```

## License

Licensed under a Creative Commons Attribution License.
See [LICENSE.txt](LICENSE.txt)

