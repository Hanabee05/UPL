Oke, aku bisa bantu poles README.md kamu biar tampilannya jauh lebih keren, terstruktur, dan menarik — cocok buat GitHub biar langsung *catchy* pas orang buka repo-nya.
Dari isi file kamu, ini versi upgrade-nya (markdown modern, emoji balance, tabel rapi, blok kode diformat, dan sedikit gaya promosi open-source yang elegan):

---

````markdown
# 🐒 **UPiL – Ukong Programming Language**

> Bahasa pemrograman **ultra-simpel** berbasis **Kotlin** dengan sintaks **100% Bahasa Indonesia**.  
> Dirancang untuk **pemula**, **pengajar**, dan **pengguna Android** yang ingin belajar logika pemrograman tanpa perlu pusing mikirin bahasa Inggris.

---

## 🎯 Tujuan

- Menurunkan *entry barrier* pemrograman dengan **kata kunci Bahasa Indonesia**.  
- Bisa dijalankan langsung di **HP Android (tanpa root)**.  
- Ringan, *interpreted*, dan cocok untuk **prototyping script kecil**.

---

## 🚀 Instalasi & Menjalankan

### Linux / macOS / Windows (via WSL)

```bash
git clone https://github.com/username/UPiL-Language.git
cd UPiL-Language
chmod +x setup.sh && ./setup.sh    # cukup sekali
./gradlew run                      # jalankan contoh
````

### Windows (PowerShell)

```powershell
gradlew.bat run
```

---

## 📺 Demo Cepat

Buat file `hello.upl`:

```upl
cetak("Halo Dunia!")
nama = masukkan("Siapa nama kamu? ")
cetak("Senang bertemu, " + nama)
```

Jalankan:

```bash
./gradlew run --args="hello.upl"
```

Output:

```
Halo Dunia!
Siapa nama kamu?
⟳ Ukong
Senang bertemu, Ukong
```

---

## 📚 Sintaks Dasar

| Konsep       | Sintaks UPiL                | Keterangan      |
| :----------- | :-------------------------- | :-------------- |
| Output       | `cetak("teks")`             | `println`       |
| Input        | `umur = masukkan("Umur: ")` | `readLine`      |
| Variabel     | `nama = "Ukong"`            | auto type       |
| Angka        | `x = bilangan("10")`        | cast ke Int     |
| If           | `jika x > 0:` ...           | indent 4 spasi  |
| Else         | `lainnya:` ...              | else block      |
| Loop (for)   | `ulang tetapi 5 kali:` ...  | `for i in 0..4` |
| Loop (while) | `selama x < 10:` ...        | `while`         |
| Fungsi       | `fungsi kuadrat(x):` ...    | `return`        |
| Komentar     | `# ini komentar`            | komentar baris  |

---

## 📦 Fitur Khusus Android *(WIP)*

| Fitur       | Sintaks UPiL                        | Deskripsi              |
| :---------- | :---------------------------------- | :--------------------- |
| Buat layout | `layar = buat_tampilan()`           | Membuat tampilan dasar |
| Tombol      | `tombol = buat_tombol("Klik Aku!")` | Elemen interaktif      |
| Event klik  | `saat tombol.diklik:` ...           | Listener               |
| Kamera      | `foto = ambil_foto()`               | Akses kamera           |
| GPS         | `lat, lon = dapatkan_lokasi()`      | Ambil lokasi pengguna  |

> 💡 Butuh peluncur APK?
> Masuk ke folder `Android-app/` lalu jalankan:
>
> ```bash
> ./gradlew assembleDebug
> ```

---

## 🧪 Contoh Program

### 1️⃣ Kalkulator Sederhana

```upl
fungsi kalkulator(a, b, op):
    jika op == "+":
        kembalikan a + b
    jika op == "-":
        kembalikan a - b
    jika op == "*":
        kembalikan a * b
    jika op == "/":
        kembalikan a / b

cetak("=== KALKULATOR UPiL ===")
a = bilangan(masukkan("Angka 1: "))
b = bilangan(masukkan("Angka 2: "))
op = masukkan("Operasi (+ - * /): ")

hasil = kalkulator(a, b, op)
cetak("Hasil:", hasil)
```

---

### 2️⃣ Tebak Angka (Game CLI)

```upl
acak = acak(1, 100)
percobaan = 0

selama benar:
    tebakan = bilangan(masukkan("Tebak angka 1-100: "))
    percobaan = percobaan + 1

    jika tebakan > acak:
        cetak("Terlalu besar!")
    jika tebakan < acak:
        cetak("Terlalu kecil!")
    jika tebakan == acak:
        cetak("Benar! Percobaan:", percobaan)
        berhenti
```

---

## 🧱 Struktur Folder

```
UPiL-Language/
├── src/main/kotlin/org/upl/
│   ├── lexer/         → Tokenisasi
│   ├── parser/        → AST
│   ├── interpreter/   → Eksekusi
│   ├── runtime/       → Fungsi bawaan
│   └── android/       → Android API
├── android-app/       → Contoh APK
├── contoh/            → Script demo
└── docs/              → Spec lengkap
```

---

## 🤝 Berkontribusi

1. **Fork** repo ini
2. Buat cabang baru

   ```bash
   git checkout -b fitur-baru
   ```
3. Commit dan push

   ```bash
   git commit -m 'tambah operator modulo'
   git push origin fitur-baru
   ```
4. Buka **Pull Request**

### 💡 Ide Kontribusi:

* Operator `**` (pangkat), `%` (modulo)
* Tipe data: desimal, daftar, peta
* Import file `.upl` di dalam script
* *Syntax sugar* untuk daftar
* Plugin Android Studio / IntelliJ
* Syntax highlighting untuk VS Code & Neovim

---

## 📄 Lisensi

**MIT License**
Bebas digunakan di kelas, bootcamp, YouTube, atau dibuat versi modifikasimu sendiri.

---

## 📬 Kontak & Komunitas

* 💬 **Telegram:** [t.me/upil_lingual](https://t.me/upil_lingual)
* 🎮 **Discord:** [bit.ly/UPiL-Discord](https://bit.ly/UPiL-Discord)
* 🐞 **Issue Tracker:** [GitHub Issues](https://github.com/username/UPiL-Language/issues)

---

> “Bahasa pemrograman tidak harus berbahasa Inggris.”
> — **Ukong, 2025**

```

---

Mau sekalian aku tambahin **badge GitHub (build, license, version, Telegram group)** dan **banner ASCII/cyberpunk** di atas biar makin punya *vibe* proyek bahasa pemrograman lokal keren?
```
