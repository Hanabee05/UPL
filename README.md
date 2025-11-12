🐒 UPiL – Ukong Programming Language
Bahasa pemrograman ultra-simpel berbasis Kotlin dengan sintaks 100% Bahasa Indonesia.
Dibuat untuk pemula, pengajar, dan pengguna Android yang pengen belajar logika pemrograman tanpa pusing mikirin bahasa Inggris.
🎯 Tujuan
Menurunkan barrier entry pemrograman dengan kata kunci Indonesia.
Bisa dijalankan langsung di HP Android (tanpa root).
Ringan & interpret, cocok untuk prototyping script kecil.
🚀 Instalasi & Run (Linux/macOS/Windows/WSL)
bash
Copy
git clone https://github.com/username/UPiL-Language.git
cd UPiL-Language
chmod +x setup.sh && ./setup.sh   # cukup sekali
./gradlew run                     # jalankan contoh
Kalau pakai Windows (PowerShell):
powershell
Copy
gradlew.bat run
📺 Demo Cepat
Buat file hello.upl:
upl
Copy
cetak("Halo Dunia!")
nama = masukkan("Siapa nama kamu? ")
cetak("Senang bertemu, " + nama)
Jalankan:
bash
Copy
./gradlew run --args="hello.upl"
Output:
Copy
Halo Dunia!
Siapa nama kamu? ⟳ Ukong
Senang bertemu, Ukong
📚 Sintaks Dasar (Bahasa Indonesia)
Table
Copy
Konsep	Sintaks UPiL	Keterangan
Output	cetak("teks")	println
Input	umur = masukkan("Umur: ")	readLine
Variabel	nama = "Ukong"	auto type
Angka	x = bilangan("10")	cast ke Int
If	jika x > 0: cetak("positif")	indent 4 spasi
Else	lainnya: cetak("negatif")	
Loop tetap	ulangi 5 kali: cetak("Hello")	for i in 0..4
Loop kondisi	selama x < 10: x = x + 1	while
Fungsi	fungsi kuadrat(x): kembalikan x * x	return
Komentar	# ini komentar	
📦 Fitur Khusus Android (WIP)
Table
Copy
Fitur	Sintaks UPiL
Buat layout	layar = buat_tampilan()
Tombol	tombol = buat_tombol("Klik Aku!")
Event klik	saat tombol.diklik: cetak("Ok!")
Ambil foto	foto = ambil_foto()
GPS lokasi	lat, lon = dapatkan_lokasi()
Butuh APK launcher? Buka folder android-app/ lalu gradlew assembleDebug.
🧪 Contoh Program
1. Kalkulator Sederhana
upl
Copy
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
2. Tebak Angka (Game CLI)
upl
Copy
acak = acak(1, 100)
percobaan = 0

selama benar:
    tebak = bilangan(masukkan("Tebak angka 1-100: "))
    percobaan = percobaan + 1
    jika tebak > acak:
        cetak("Terlalu besar!")
    jika tebak < acak:
        cetak("Terlalu kecil!")
    jika tebak == acak:
        cetak("Benar! Percobaan:", percobaan)
        berhenti
🧱 Struktur Folder
Copy
UPiL-Language/
├── src/main/kotlin/org/upl/
│   ├── lexer/        → Tokenisasi
│   ├── parser/       → AST
│   ├── interpreter/  → Eksekusi
│   ├── runtime/      → Built-in func
│   └── android/      → Android API
├── android-app/      → Sample APK
├── examples/         → Script demo
└── docs/             → Spec lengkap
🤝 Berkontribusi
Fork repo ini
Buat branch (git checkout -b fitur-baru)
Commit (git commit -m 'tambah operator modulo')
Push (git push origin fitur-baru)
Buka Pull Request
🧩 Ide kontribusi
Operator ** (pangkat), % (modulo)
Tipe data desimal, daftar, peta
Import file .upl dari dalam script
Syntax sugar untuk tiap daftar: ...
Android Studio Plugin / IntelliJ Plugin
Syntax highlighting untuk VS Code / Neovim
📄 Lisensi
MIT License – bebas dipakai di kelas, bootcamp, YouTube, atau dibuat versi barumu sendiri.
📬 Kontak & Komunitas
Telegram Group: t.me/upil_language
Discord: bit.ly/UPiL-Discord
Issue tracker: GitHub Issues (lap bug & request fitur)
"Bahasa pemrograman tidak harus berbahasa Inggris." – Ukong, 2025
