# MangaMint

<p align="center">
<img alt="GitHub issues" src="https://img.shields.io/github/issues/febryardiansyah/manga_mint">
<img alt="GitHub pull requests" src="https://img.shields.io/github/issues-pr/febryardiansyah/manga_mint">
<img alt="GitHub" src="https://img.shields.io/github/license/febryardiansyah/manga_mint"> 
<img alt="GitHub stars" src="https://img.shields.io/github/stars/febryardiansyah/manga_mint">
<img alt="GitHub forks" src="https://img.shields.io/github/forks/febryardiansyah/manga_mint">
<img alt="GitHub watchers" src="https://img.shields.io/github/watchers/febryardiansyah/manga_mint">
<img alt="GitHub contributors" src="https://img.shields.io/github/contributors/febryardiansyah/manga_mint">
<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/febryardiansyah/manga_mint">
</p>

MangaMint is manga reader application that provides manga and comic bahasa indonesia and currently
available on android only, idk in the future will be available on ios or not

## Usage
1. Download or clone this repository [manga-api](https://github.com/febryardiansyah/manga-api)
    > git clone https://github.com/febryardiansyah/manga-api
2. you have to deploy this api by yourself `(You can use heroku,vercel, or glitch)`
2. change `const String BaseUrl = 'https://10.0.2.2:8000/api/';` (<manga_mint>/lib/constants/base_url.dart) to your API. ex: `example.herokuapp.com.com/api/`

## Prototype of This App
[MangaMint Protyotype](https://www.figma.com/proto/tEwOEwAIycAuWfMOCffG3w/customDesign?node-id=591%3A3&scaling=scale-down)

## Download Apk
[mangamint.apk](https://github.com/febryardiansyah/manga_mint/releases/tag/v.1.0)

## Features
- [x] Manga List (Japanase Comic)
- [x] Manhua List (Chinese Comic)
- [x] Manhwa List (Korean Comic)
- [x] Last chapter update
- [x] Bookmarks Manga
- [x] Read last chapter opened
- [x] Search Manga by name and Genres
- [x] Read chapter vertically or horizontally

## Screenshot
<img src="assets/ss/ss1.png" width="30%"> <img src="assets/ss/ss2.png" width="30%">
<img src="assets/ss/ss3.png" width="30%"> <img src="assets/ss/ss4.png" width="30%">
<img src="assets/ss/ss5.png" width="30%"> <img src="assets/ss/ss6.png" width="30%">
<img src="assets/ss/ss7.png" width="30%"> <img src="assets/ss/ss8.png" width="30%">

## Build Setup
``` bash

# install dependencies
$ flutter pub get

# run debug mode
$ flutter run

# run release mode
$ flutter run --release

# build app bundle
$ flutter build appbundle

# build apk
$ flutter build apk

```
## Dependencies that i use
- http: ^0.12.1
- bloc: ^5.0.1
- flutter_bloc: ^5.0.1
- google_fonts: ^1.1.0
- equatable: ^1.2.0
- rxdart: ^0.24.1
- ff_navigation_bar: ^0.1.5
- flutter_spinkit: ^4.1.2+1
- shimmer: ^1.1.1
- carousel_slider: ^2.2.1
- flutter_screenutil: ^2.2.0
- cached_network_image: ^2.2.0+1
- photo_view: ^0.9.2
- shared_preferences: ^0.5.8
- path_provider: ^1.6.11
- path: ^1.7.0
- hive: ^1.4.1+1
- hive_flutter: ^0.2.1
- toast: ^0.1.5
- font_awesome_flutter: ^8.8.1
- url_launcher: ^5.5.0

For detailed explanation on how things work, check out [Flutter docs](https://flutter.dev/docs).

