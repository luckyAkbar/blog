---
title: "3 Langkah Mudah Membuat CI/CD Pipeline"
date: 2025-09-14 12:00:00 +0000
categories: ["devops", "ci/cd", "automation"]
tags: ["devops", "automation"]  
author: Lucky
layout: post
summary: Tiga langkah sederhana membuat CI/CD pipeline adalah mempersiapkan repository github, membuat github action dan mempersiapkan layanan watchtower.
description: Proses pembuatan CI/CD pipeline dengan 3 langkah sederhana yang bisa membuat software yang dikembangkan bisa diperbarui dengan otomasi yang dapat dilakukan dengan singkat.
---

## Definisi CI/CD

Istilah CI/CD sering kali digunakan bersamaan, namun keduanya merupakan komponen terpisah yang acap kali bekerja bersama-sama membentuk sebuah sistem yang lebih besar. Berdasarkan definisi, mengutip dari buku [GitHub Actions in Action karya Michael Kaufmann](https://www.manning.com/books/github-actions-in-action) dkk, CI (_Continuous Integration_) adalah proses yang berjalan pada tahapan DevOps yang melakukan penggabungan kode hasil pengembangan pada sebuah repository dan menjalankan proses _build_ terotomasi guna melakukan pengecekan kualitas dan betul-salahnya kode sumber program tersebut. Tujuan utama dari proses CI adalah untuk menyediakan umpan balik yang cepat terhadap setiap perubahan yang terjadi pada kode, seperti adanya fitur baru yang merusak fitur lama, pengujian unit, pengujian performa dan sejenisnya. Umpan balik ini bisa digunakan oleh pengembang untuk memastikan fitur yang dibuat sudah sesuai standar kualitas kode yang ada. Sebagaimana definisinya, CI dipicu oleh perubahan pada kode, baik berupa _pull request_ ataupun proses _push_ ke _branch_ tertentu.

Berbeda halnya dengan CD (_Continuous Delivery_), proses CD bertanggung jawab untuk melakukan _deployment_ perangkat lunak yang telah dibuat ke lingkungan _production_ (ataupun lingkungan lain sesuai kebutuhan) secara terotomasi. Proses CD bertujuan untuk membuat setiap perubahan, fitur dan perbaikan yang terjadi di sistem perangkat lunak yang telah dibuat bisa dirasakan dan digunakan oleh pengguna dalam waktu yang sesingkat-singkatnya.

## Komponen CI/CD Pipeline

Berdasarkan penjelasan dari bagian definisi CI/CD, terdapat beberapa komponen pendukung di masing-masing bagian. Secara umum, komponen dari bagian CD terdiri dari:

1. VCS (_Version Control System_) (seperti: git; github; gitlab; bitbucket; dsb)
2. Pengujian terotomasi
3. _Software packaging_

Ketiga komponen ini tidaklah mutlak dan sama di setiap project perangkat lunak, namun ketiganya merupakan komponen kunci di bagian CI. VCS berguna sebagai alat untuk mengontrol perubahan pada kode sumber dan menjadi pemicu berjalannya proses CI. Pengujian terotomasi berguna untuk memastikan kualitas kode serta meningkatkan rasa percara diri pengembang terhadap fitur yang sudah dibuat, dan _software packaging_ akan sangat berguna untuk tahapan CD dengan membuat perangkat lunak lebih mudah dijalankan dan dikemas dalam bentuk yang seragam (seperti penggunaan [docker](https://www.docker.com/)).

Pada bagian CD, berikut adalah komponen-komponen umum yang menjadi bagian dari proses ini:

1. Server / Komputer lokasi _deployment_
2. Mekanisme pemicu (_trigger mechanism_)
3. _Deployment processor_ (contoh: _rolling release mechanism_)

Ketiga komponen tersebut membentuk proses CD secara umum, dimana mekanisme pemicu bekerja untuk mendeteksi apakah sudah ada versi terbaru dari perangkat lunak, dan jika terdeteki, maka akan memicu proses _deployment_. Proses _deployment_ akan membuat supaya versi terbaru dari perangkat lunak terinstall dan berjalan di server lokasi tujuan lingkungan _deployment_. Ketiga langkah yang akan dibahas pada artikel ini akan mencakup semua bagian komponen dari proses CI/CD.

## Langkah 1: Mempersiapkan _repository_ perangkat lunak

Pada tahapan ini bisa menggunakan berbagai macam perangkat lunak, baik berupa aplikasi berbasis website, mobile ataupun API. Akan tetapi, artikel ini akan menggunakan sebuah proyek khusus berupa _static site generator_ yang dibuat berdasarkan [jekyll](https://jekyllrb.com/) dan menggunakan tema [chirpy](https://github.com/cotes2020/jekyll-theme-chirpy). Pergi ke repository [chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) dan fork repositori tersebut. Beri nama sesuai keinginan Anda, saya menggunakan nama "blog". Karena sebelumnya repository chirpy telah memiliki github workflows, hapus saja folder ".github" dan semua isinya. Kita akan membuat workflow custom di tahapan selanjutnya.

## Langkah 2: Mempersiapkan Github Actions

Pada tahapan ini kita akan mempersiapkan Github Actions yang akan bertindak sebagai proses melakukan _software packaging_. Kita juga akan memanfaatkan docker supaya pada tahapan CD kita bisa memastikan perangkat lunak bisa langsung berjalan tanpa harus memikirkan _dependenciesnya_. Berikut adalah detail dari bagian-bagian langkah ini:

1. Buat file Dockerfile

    Buat file bernama Dockerfile di _root directory_ proyek, dan isi file tersebut dengan sintaks di bawah ini.
    ```Dockerfile
    FROM ruby:3.2.3-alpine AS builder

    RUN apk add --no-cache --update build-base git
    WORKDIR /app
    COPY Gemfile Gemfile.lock ./
    RUN bundle config set without 'development test' && \
        bundle install

    COPY . .
    RUN JEKYLL_ENV=production bundle exec jekyll build

    FROM nginx:alpine
    RUN rm -rf /usr/share/nginx/html/*
    COPY --from=builder /app/_site /usr/share/nginx/html
    EXPOSE 80
    ```

    File ini akan melakukan kompilasi kode sumber menjadi _static site_ dan kemudian menggunakan NGINX sebagai web server yang nantinya akan memproses permintaan terhadap _static site_ yang telah dibuat.

2. Persiapkan Workflows

    Workflows pada Github adalah file yang berisi detail langkah dan proses yang dilakukan sebagai bagian dari otomasi. Ada banyak hal yang bisa dilakukan pada workflows, diantaranya namun tidak terbatas pada otomasi _unit testing_, proses kompilasi kode program, manajemen permintaan perubahan (_pull request_) bahkan hingga otomasi proses _deployment_. Workflows yang akan dibuat pada artikel ini akan mencakup proses pembuatan _docker image_ dan kemudian melakukan _push_ image yang sudah di buat ke GHCR (Github Container Registry). Cara membuat file workflows nya adalah dengan membuat sebuah file yang bernama `build-and-push.yml` dan tempatkan di folder `.github/workflows`. Isi file tersebut dengan sintaks di bawah ini:

    ```yaml
    name: Build and Push the Docker Image

    on:
        push:
            branches: ["master"]

    permissions:
        contents: read
        packages: write

    jobs:
        build-and-push:
            runs-on: ubuntu-latest
            steps:
                - name: Checkout repository
                uses: actions/checkout@v5

                - name: Log in to GitHub Container Registry
                uses: docker/login-action@v3
                with:
                    registry: ghcr.io
                    {% raw %}username: ${{ github.actor }}{% endraw %}
                    {% raw %}password: ${{ secrets.GHCR_PAT }}{% endraw %}

                - name: Set up Docker Buildx
                uses: docker/setup-buildx-action@v3
                
                - name: Build and Push
                uses: docker/build-push-action@v5
                with:
                    context: .
                    file: ./Dockerfile
                    push: true
                    tags: |
                        ghcr.io/<isi_username_github_anda_di_sini>/blog:latest
                    cache-from: type=gha
                    cache-to: type=gha,mode=max
    ```

    Kode `yml` pada baris ke 3 hingga 5 menunjukan sebuah pemicu yang akan menjadi awal mula proses workflows berjalan, yaitu adanya _push_ ke branch _master_. Ketika terjadi, proses workflow yang ada di file tersebut akan berjalan. Baris ke 11 hingga 37 menunjukan keseluruhan alur proses yang akan dilaksanakan. Pada baris 13 menunjukan sistem operasi yang akan digunakan, kemudian pada baris ke-14 menunjukan langkah-langkah proses yang berjalan, mulai dari _checkout_ kode, _log in_ ke GHCR mempersiapkan `buildx` dan terakhir membuat docker image dan melakukan _push_ ke GHCR. Ekspektasi hasil docker image yang di push ke GHCR akan selalu di berikan tag `latest` di artikel kali ini untuk menyederhanakan proses.

    Perlu diperhatikan pada sintaks di baris ke 35, Anda harus mengganti username github anda di _placeholder_ yang sudah disediakan. 

3. Menyiapkan Github Secrets

    Jika anda memperhatikan di [Langkah 2](#langkah-2-mempersiapkan-github-actions) tahap 2 di baris kode ke 23 terdapat sintaks khusus: `{{ secrets.GHCR_PAT }}`. Bagian tersebut termasuk kedalam `Github Secrets` yang merupakan sebuah data rahasia, seperti password, API Key, dsb yang akan digunakan di dalam workflows namun tidak bersifat publik. Github Secrets yang digunakan di workflows bernama GHCR_PAT yang merupakan akses token untuk melakukan manipulasi (read / update / create) docker image di GHCR. Berikut adalah langkah dalam mendapatkan PAT anda untuk digunakan.

    - Kunjungi laman [setting profile](https://github.com/settings/profile).
    - Pada tab di area kiri, Klik bagian `Developer Options`.
    - Klik bagian `Personal access token` > `Tokens (classic)`.
    - Klik `Generate new token` > `Generate new token (classic)`
    - Isi formulir pembuatan token, seperti bagian `Note` dan kemudian ceklis bagian `scope` > `write:packages`. Hanya permission tersebut yang diperlukan, dan hindari melakukan ceklis permission lain.
    - Klik `Generate token`.
    - Copy token PAT Anda, dan pastikan anda menyimpannya dengan baik (sesuai petunjuk Github).

    Kemudian, kembali ke repository `blog` Anda. Untuk menambahkan Github Secrets, lakukan:
    
    - Klik tab `Settings`
    - Pada tab di area kiri, klik `Secrets and variables` > `Actions`
    - Klik `New Repository Secrets`
    - Pada bagian `Name`, isi `GHCR_PAT`
    - Pada bagian `Secret`, paste token PAT yang Anda dapat
    - Klik `Add secret`

    Bagian Github Secrets telah selesai.

## Langkah 3: Mempersiapkan server lokasi deployment

Pada tahapan ini, Anda bisa menyediakan sebuah server berbasis Ubuntu, atau juga bisa komputer lokal dengan sistem operasi yang sama dan terhubung dengan internet. Pastikan pada komputer lokal ataupun server anda sudah [terinstall docker](https://docs.docker.com/engine/install/). Ada dua hal yang akan dilakukan pada tahapan ini, yakni melakukan setup service watchtower dan juga mempersiapkan docker container yang akan menjalankan docker image hasil dari tahapan sebelumnya.

[Watchtower](https://github.com/containrrr/watchtower) adalah sebuah service yang dapat menjalankan proses deployment dengan melakukan monitoring terhadap update pada basis docker image di setiap kontainer berjalan. Service watchtower bisa dijalankan dengan menggunakan docker compose. Pada server ataupun komputer lokal anda, buat sebuah folder khusus bernama `watchtower` dan buat file `compose.yaml` di dalamnya. Masukan kode berikut ke file `compose.yaml`:

```yaml
services:
    watchtower:
        image: containrrr/watchtower:1.7.1
        container_name: watchtower
        volumes:
            - /var/run/docker.sock:/var/run/docker.sock
        environment:
            - TZ=Asia/Jakarta
        restart: unless-stopped
        command:
            - "--label-enable"
            - "--interval"
            - "60"
            - "--rolling-restart"
```

File `compose.yaml` di atas akan menjalankan layanan watchtower dengan detail perintah yang didefinisikan secara khusus di baris ke 10 hingga 14, dimana perintah tersebut akan membuat watchtower hanya melakukan monitoring perubahan pada container yang memiliki label khusus (akan dijelaskan nanti) dan juga melakukan update dengan teknik _rolling update_ agar tidak menimbulkan _downtime_ ketika proses update berjalan. Setelah selesai, jalankan perintah `docker compose up` di lokasi yang sama dengan file `compose.yaml` berada. Service watchtower akan berjalan di latar belakang.

Selanjutnya, kita bisa mempersiapkan untuk menjalankan kontainer yang akan menjadi server yang melayani permintaan ke blog yang telah dibuat. Buat sebuah folder khusus bernama `blog` dan kemudian buat sebuah file `compose.yaml` di dalamnya. Setelah itu, isi file tersebut dengan kode di bawah ini.

```yaml
services:
    blog:
        image: ghcr.io/<isi_username_github_anda_di_sini>/blog:latest
        container_name: "blog-from-jekyll-chirpy-theme"
        environment:
            - TZ=Asia/Jakarta
        expose:
            - 80
        restart: unless-stopped
        labels:
          - "com.centurylinklabs.watchtower.enable"
```

Sebelum anda menyimpan perubahan pada file tersebut, pastikan anda sudah mengganti username github anda dengan yang anda gunakan di file workflows. Apabila terlupa, proses menjalankan container akan gagal. Perlu diperhatikan juga bahwasannya labels yang ada di baris ke 11 harus dimiliki oleh setiap kontainer yang ingin dimonitor dan diupdate oleh watchtower. Anda juga harus selalu menyertakan tag di bagian image karena watchtower akan melakukan monitoring perubahan docker image yang memiliki tag yang sama. Setelah itu anda bisa menjalankan perintah `docker compose up` di folder yang sama dengan file `compose.yaml` di atas.

Anda bisa kunjungi `localhost:80` (apabila menggunakan komputer lokal) atau `ip:80` apabila dideploy pada server public untuk mengecek dan memastikan website sudah berjalan. Pastikan anda melihat website berbasis jekyll dan bertema chirpy di browser anda. Setelah selesai, langkah ke tiga ini pun sudah selesai dan kita siap untuk memicu proses CI/CD yang sudah kita buat.

## Memicu dan Menguji CI/CD Pipeline

Sesuai dengan sintaks workflows yang telah dibuat, setiap ada perubahan yang berada pada branch `master` akan memicu proses CI. Apabila Github Actions telah selesai, docker image yang telah diperbarui akan memicu proses CD yang akan diproses oleh watchtower. Pada tahapan ini, saya akan membuka sebuah `pull request` untuk melakukan otomasi yang bertujuan untuk mempublish artikel ini. Artikel ini akan tayang di laman [website pribadi saya](https://blog.luckyakbar.web.id). Berikut adalah kondisi sebelum proses CI/CD berjalan.

![kondisi awal](assets/img/kondisi-awal-sebelum-ci-cd-berjalan.png)

Terlihat hanya ada satu artikel pada website tersebut, sedangkan artikel ini belum tayang. Pull request untuk memposting artikel ini akan ada di [pull request #3](https://github.com/luckyAkbar/blog/pull/2). Setelah pull request tersebut di merge ke branch master, artikel ini akan secara otomatis tayang di url ini: [https://blog.luckyakbar.web.id/posts/3-Langkah-Mudah-Membuat-CI-CD-Pipeline/](https://blog.luckyakbar.web.id/posts/3-Langkah-Mudah-Membuat-CI-CD-Pipeline/).

## Kesimpulan

Demikian adalah 3 langkah sederhana yang menjadi komponen utama untuk menerapkan proses CI/CD di proyek yang kita buat. Proses CI/CD ini akan berbeda di setiap proyek, sesuai dengan kebutuhan masing-masing. Akan tetapi, masing-masing komponen pendukung, baik pada CI ataupun CD akan selalu ada di masing-masing CI/CD pipeline. Saya berharap setelah membaca artikel ini, anda juga melakukan latihan secara langsung untuk menerapkan CI/CD pipline Anda, baik mengikuti proses pada artikel ini ataupun membuat pipeline custom anda sendiri.