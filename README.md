# gen-labels
A shell script to gen text labels for gxkb

![screenshot 1](http://storage5.static.itmages.ru/i/16/1012/h_1476301696_1383324_8e6615278a.png "gxkb layouts")

```bash
zen@desktop:~/gen-labels$ ./gen_labels.sh -h
Usage: gen_labels.sh [OPTIONS]

--fc         - font color
--bc         - background color
--sc         - shadow color
--dir        - output directory
--bold       - use bold font
--format     - type of string formatting
               0 - us, 1 - US, 2 - Us (Default)
-h | --help  - show this help

zen@desktop:~/gen-labels$ ./gen_labels.sh --format=0 --fc=#FFFFFF --bc=#373737 --sc=#000000
* Generating '/home/zen/gen-labels/images/am.png'
* Generating '/home/zen/gen-labels/images/bg.png'
* Generating '/home/zen/gen-labels/images/by.png'
* Generating '/home/zen/gen-labels/images/cz.png'
* Generating '/home/zen/gen-labels/images/de.png'
* Generating '/home/zen/gen-labels/images/ee.png'
* Generating '/home/zen/gen-labels/images/es.png'
* Generating '/home/zen/gen-labels/images/fr.png'
* Generating '/home/zen/gen-labels/images/gb.png'
* Generating '/home/zen/gen-labels/images/ge.png'
* Generating '/home/zen/gen-labels/images/gr.png'
* Generating '/home/zen/gen-labels/images/hr.png'
* Generating '/home/zen/gen-labels/images/hu.png'
* Generating '/home/zen/gen-labels/images/is.png'
* Generating '/home/zen/gen-labels/images/it.png'
* Generating '/home/zen/gen-labels/images/kz.png'
* Generating '/home/zen/gen-labels/images/lt.png'
* Generating '/home/zen/gen-labels/images/lv.png'
* Generating '/home/zen/gen-labels/images/no.png'
* Generating '/home/zen/gen-labels/images/pl.png'
* Generating '/home/zen/gen-labels/images/pt.png'
* Generating '/home/zen/gen-labels/images/ro.png'
* Generating '/home/zen/gen-labels/images/ru.png'
* Generating '/home/zen/gen-labels/images/se.png'
* Generating '/home/zen/gen-labels/images/si.png'
* Generating '/home/zen/gen-labels/images/sk.png'
* Generating '/home/zen/gen-labels/images/sr.png'
* Generating '/home/zen/gen-labels/images/ua.png'
* Generating '/home/zen/gen-labels/images/us.png'
* Generating '/home/zen/gen-labels/images/uz.png'
* Generating '/home/zen/gen-labels/images/fi.png'
* Generating '/home/zen/gen-labels/images/zz.png'
```
