---
title: "Cara Mengamankan Virtual Private Server"
date: 2025-09-04 12:00:00 +0000
categories: ["vps", "server", "cloud", "security"]
tags: ["security", "cloud"]  
author: Lucky
layout: post
summary: Beberapa cara yang bisa digunakan untuk membuat VPS kita lebih aman.
description: Teknik pengamanan server yang mudah dilakukan namun dapat berdampak besar terhadap keamanan server kita yang terekspos secara publik, mulai dari SSH hardening hingga pengaturan firewall.
---


# VPS (Virtual Private Server)

VPS adalah sebuah komputer virtual yang umumnya disewakan oleh cloud provider (e.g Google Cloud, AWS, DigitalOcean, dsb) yang bisa digunakan untuk berbagai keperluan. VPS umumnya dibeli untuk digunakan dalam berbagai kebutuhan, seperti deployment website, API server, dan lain-lain. Dengan kebutuhan demikian, sering kali VPS dapat diakses oleh publik melalui internet. Hal ini memberikan dampak baik dimana semua orang bisa mengakses server ataupun aplikasi yang dideploy di server tersebut. Dilain sisi, hal ini justru memberikan bahaya dimana _bad actor_ bisa saja menargetkan VPS kita dan memberikan berbagai serangan siber. Hal ini bisa berdampak pada terganggunya pengguna yang legit, aplikasi yang berhenti beroperasi, hingga mengganggu jalannya bisnis.

Dengan adanya resiko ini, perlu adanya tindak pengamanan yang harus dilakukan agar VPS dapat melayani pengguna namun tetap terhindar dari serangan siber. Hal yang perlu dilakukan untuk mengamankan VPS hanya membutuhkan beberapa langkah sederhana, namun dapat berdampak besar terhadap keamanan VPS secara keseluruhan. Berikut adalah penerapan keamanan dari masing-masing sisi, alasan mengapa harus dilakukan, langkah-langkah yang perlu dilakukan, hingga contoh perintah-keluaran dari masing-masing langkah.

## Prasayarat

Sebelum mengikuti tutorial ini, Anda diharapkan memiliki akses ke VPS yang berbasis Linux. Kemudian saya juga mengharapkan anda familiar dengan perintah berbasis _command line_ untuk menjalankan beberapa perintah yang diperlukan.

## Buat Pengguna VPS baru selain root

Login via _root_ sangat tidak direkomendasikan untuk bisa dilakukan pada VPS yang terekspos secara publik karena dapat membahayakan adanya akses ke dalam VPS yang langsung memiliki _privilege_ paling tinggi. Ibaratnya apabila ada seorang pencuri yang masuk ke dalam rumah bisa langsung masuk ke dalam brankas. Sistem keamanan yang baik tentunya tidak memperbolehkan hal ini terjadi, maka dari itu, login via root (melalui SSH) harus dinonaktifkan. Berikut adalah langkah-langkah yang harus dilakukan:


1. Login via SSH

    Cara ini harus terlebih dahulu dilakukan. umumnya bisa langsung via SSH key, atau menggunakan password sesuai dengan provider anda. Perintah yang dilakukan adalah

    `~$ ssh root@ip`

    Setelah perintah tersebut dijalankan, anda sudah terhubung dengan VPS. Masukan password apabila anda menggunakan metode login dengan password.

2. Buat akun pengguna baru

    Dilangkah ini kita harus membuat pengguna baru yang kedepannya akan digunakan untuk login ke VPS. Perintah yang dilakukan adalah `adduser <namauser>`, dan kemudian diwajibkan untuk mengisi password untuk pengguna tersebut dengan password yang aman namun mudah diingat, dan setelah itu anda akan diminta untuk mengisi detail (opsional) pengguna baru tersebut. Berikut adalah contoh penggunaan perintah tersebut.

    ```bash
    root@main-server:~# adduser lucky
    info: Adding user `lucky' ...
    info: Selecting UID/GID from range 1000 to 59999 ...
    info: Adding new group `lucky' (1000) ...
    info: Adding new user `lucky' (1000) with group `lucky (1000)' ...
    info: Creating home directory `/home/lucky' ...
    info: Copying files from `/etc/skel' ...
    New password:
    Retype new password:
    passwd: password updated successfully
    Changing the user information for lucky
    Enter the new value, or press ENTER for the default
            Full Name []:
            Room Number []:
            Work Phone []:
            Home Phone []:
            Other []:
    Is the information correct? [Y/n] Y
    info: Adding new user `lucky' to supplemental / extra groups `users' ...
    info: Adding user `lucky' to group `users' ...
    ```

3. Tambahkan pengguna baru ke grup `sudo`

    Langkah ini bertujuan untuk memberikan akses khusus ke pengguna tersebut yang membuatnya bisa menjalankan perintah dengan _privilege_ `sudo` sehingga kita tidak perlu lagi login langsung ke pengguna `root`. Berikut adalah perintah yang harus dijalankan:

    ```bash
    root@main-server:~# usermod -aG sudo lucky
    ```

4. Pindah ke pengguna baru

    Anda bisa langsung pindah dan mengakses VPS ke pengguna yang baru saja dibuat dengan menggunakan perintah `root@main-server:~# su <usernam>`. Setelah itu anda akan mengakses VPS dengan pengguna non-root.

5. Tes akses `sudo`

    Untuk mengetes apakah pengguna baru tersebut sudah bisa mengakses _privilege_ `sudo`, anda bisa menjalankan perintah `sudo ls /`. Apabila berhasil, keluaran perintah tersebut adalah daftar folder yang ada di `/`. Berikut adalah contoh keluaran apabila pengguna baru bisa mengakses _privilege_ sudo.

    ```bash
    lucky@main-server:~$ sudo ls /
    [sudo] password for lucky:
    bin                boot  etc   lib                lib64       media  opt   root  sbin
    ```

6. Copy Public SSH Key ke pengguna baru

    Tahapan ini dilakukan agar kita bisa mengakses login SSH ke pengguna baru dengan menggunakan SSH key karena login via password akan dinonaktifkan. Caranya adalah dengan membuat file khusus `~/.ssh/authorized_keys` dan kemudian paste public key komputer anda ke file tersebut. Berikut adalah perintah yang digunakan untuk melakukannya.

    ```bash
    lucky@main-server:~$ mkdir .ssh
    lucky@main-server:~$ touch .ssh/authorized_keys
    ```

    setelah file `~/.ssh/authorized_keys` berhasil dibuat, copy SSH public key anda (laptop / komputer yang akan digunakan untuk mengakses VPS), bisa menggunakan perintah di `$ cat .ssh/id_ed25519.pub` atau lihat di [stackoverflow](https://askubuntu.com/questions/4830/easiest-way-to-copy-ssh-keys-to-another-machine). Setelah itu, paste public SSH key anda ke line baru di file `~/.ssh/authorized_keys`. Berikut contoh dari isi file `~/.ssh/authorized_keys`.

    ```bash
    lucky@main-server:~$ cat ~/.ssh/authorized_keys
    ssh-ed25519 <contoh public key string> namakomputer
    ```

7. Login ke VPS menggunakan pengguna baru

    Setelah selesai menambahkan SSH public key anda ke file `~/.ssh/authorized_keys`, anda bisa mengetes untuk login ke VPS anda dengan pengguna yang anda baru buat dan memanfaatkan SSH key. Caranya bisa langsung menjalankan perintah `ssh <pengguna>@public.ip.vps.anda`. Apabila berhasil, berarti pengguna baru anda sudah siap digunakan dan bisa login tanpa harus menggunakan `root`.

## Deaktifasi metode login dengan password

Salah satu metode login ke VPS yang umumnya secara bawaan bisa digunakan adalah login dengan password. Hal ini perlu dinonaktifkan karena metode ini cenderung rentan dengan serangan _bruteforce_ yang bisa dilakukan secara terotomasi oleh penyerang. Ditambah dengan penggunaan password yang lemah bisa menjadikan anda kehilangan akses ke VPS anda dengan mudah. Berikut adalah detail langkah-langkah yang harus dilakukan untuk menonaktifkan login via password dan hanya memperbolehkan login via SSH keys.

1. Ubah konfigurasi SSH daemon

    File konfigurasi SSH daemon terletak pada `/etc/ssh/sshd_config`. Kita perlu melakukan beberapa perubahan untuk menonaktifkan login via password. Berikut adalah daftar konfigurasi yang harus terlebih dahulu dicari

    - `PasswordAuthentication`
    - `PermitRootLogin`
    - `UsePAM`

    Apabila konfigurasi tersebut ada di file `/etc/ssh/sshd_config`, anda harus ubah nilai konfigurasinya seperti contoh di bawah untuk menonaktifkan SSH via password. Pastikan di awal baris masing-masing konfigurasi ini tidak didahului dengan karakter `#` yang artinya konfigurasi tersebut tidak aktif.

    ```plaintext
    PermitRootLogin no
    PasswordAuthentication no
    UsePAM no
    ```

    Setelah selesai, simpan perubahan pada file tersebut. 

2. Restart layanan SSH

    Karena ada perubahan pada konfigurasi SSH, kita harus melakukukan _restart_ terhadap layanan SSH dengan menjalankan perintah `sudo systemctl reload ssh`. Setelah itu, apabila anda mencoba login ke VPS tanpa memiliki SSH public key yang cocok, anda tidak akan bisa login ke VPS seperti pada contoh pesan galat di bawah ini.

    ```bash
    ssh <user>@ip
    The authenticity of host 'ip (ip)' can't be established.
    ED25519 key fingerprint is SHA256:string.
    <user>@ip: Permission denied (publickey).
    ```

## Memperkuat Firewall VPS

[_Firewall_](https://www.cloudflare.com/learning/security/what-is-a-firewall/) secara sederhana adalah sebuah sistem keamanan yang memonitor dan mengontrol lalu lintas jaringan berdasarkan kumpulan aturan keamanan jaringan tertentu. _Firewall_ pada VPS dapat digunakan untuk menutup akses ke port tertentu, membuka akses ke port tertentu, atau membuat aturan terhadap siapa saja yang boleh terhubung ke VPS melalui port tertentu. _Firewall_ pada VPS dapat dimanfaatkan untuk menutup port yang tidak perlu sehingga dapat mengurangi [_attack surface_](https://en.wikipedia.org/wiki/Attack_surface).

Pada dasarnya, kebutuhan akan port mana saja yang harus dibuka dari sebuah VPS sangatlah bergantung pada kebutuhan. Akan tetapi, lazimnya masing-masing VPS perlu membuka 3 port, yakni

- SSH (port 22)
- HTTP (port 80)
- HTTPS (port 443)

Apabila ada aplikasi yang berjalan selain daripada port di atas, sebaiknya kita gunakan teknik lain untuk dapat terhubung tanpa harus secara langsung membuat akses terhadap port selain di atas itu publik, seperti menggunakan [_reverse proxy_](https://www.cloudflare.com/learning/cdn/glossary/reverse-proxy/).

Pada VPS berbasis linux, sudah ada aplikasi yang siap digunakan sebagai firewall dan relatif mudah, yakni [ufw](https://help.ubuntu.com/community/UFW) (Uncomplicated Firewall) yang sudah terinstall secara bawaan di beberapa distribusi sistem operasi linux (contoh: Ubuntu). Pada tahapan ini saya akan membuka akses kepada port 22, 80 dan 443 serta menutup semua akses ke selain ketiga port tersebut. Berikut adalah langkah-langkah melakukannya.

1. Cek Status ufw

    Jalankan perintah `ufw status` untuk mengecek apakah sudah ada instalasi ufw di VPS anda.

    ```bash
    lucky@main-server:~$ sudo ufw status
    Status: inactive
    ```

2. Larang semua permintaan jaringan masuk (_inbound request_) secara bawaan.

    Jalankan perintah `sudo ufw default deny incoming` untuk mencegah semua permintaan masuk ke VPS kecuali secara ekplisit diperbolehkan di aturan-aturan berikutnya.
    ```bash
    lucky@main-server:~$ sudo ufw default deny incoming
    Default incoming policy changed to 'deny'
    (be sure to update your rules accordingly)
    ```

3. Perbolehkan semua permintaan jaringan keluar (_outbount request_) secara bawaan.

    Hal ini diperlukan supaya VPS dapat terhubung ke internet apabila diperlukan. Jalankan perintah `sudo ufw default allow outgoing`.

    ```bash
    lucky@main-server:~$ sudo ufw default allow outgoing
    Default outgoing policy changed to 'allow'
    (be sure to update your rules accordingly)
    ```

4. Perbolehkan akses ke port SSH, HTTP dan HTTPS

    Hal ini dapat disesuaikan dengan kebutuhan, namun pada kesempatan kali ini kita akan memperbolehkan akses ke 3 port tersebut. Berikut adalah seluruh perintah yang harus dijalankan
    - `sudo ufw allow OpenSSH`
    - `sudo ufw allow 80`
    - `sudo ufw allow 443`

5. Cek konfigurasi firewall

    Sebelum mengaktifasi ufw, kita harus mengecek apakah semua aturan _firewall_ sudah termuat dengan benar dengan menjalankan perintah `sudo ufw show added`.

    ``` bash
    lucky@main-server:~$ sudo ufw show added
    Added user rules (see 'ufw status' for running firewall):
    ufw allow OpenSSH
    ufw allow 80
    ufw allow 443
    ```

    Pada tahapan ini, anda harus minimal memastikan ufw sudah memperbolehkan akses ke port 22 / OpenSSH. Apabila aturan ini tidak termuat, maka VPS anda tidak bisa diakses kembali melalui SSH.

6. Aktifasi ufw

    Untuk memastikan aturan UFW sudah termuat dan diterapkan, kita bisa mengaktifasi ufw dengan perintah `sudo ufw enable`.

    ```bash
    lucky@main-server:~$ sudo ufw enable
    Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
    Firewall is active and enabled on system startup
    ```

## Langkah Selanjutnya

Langkah-langkah selanjutnya yang bisa digunakan untuk mengamankan VPS diantaranya ada penggunaan _reverse proxy_, integrasi dengan sistem anti [DDOS](https://www.cloudflare.com/learning/ddos/what-is-a-ddos-attack/) (Distributed Denial of Service) dan lain sebagainya. Namun teknik tersebut berada di luar teknik dasar pengamanan VPS yang mungkin akan dibahas di postingan lain.

## Penutup

Beberapa teknik yang dipaparkan di postingan kali ini bertujuan untuk melakukan pengamanan dasar terhadap VPS yang terekspos secara publik. Detail dari masing-masing teknik dapat disesuaikan secara kebutuhan, namun penerapan yang diberikan di postingan ini adalah bagian paling mendasar untuk membuat VPS kita lebih aman dari serangan siber yang paling marak terjadi. Sekian untuk postingan kali ini, dan apabila ada pertanyaan, anda bisa hubungi saya via email. Terimakasih.