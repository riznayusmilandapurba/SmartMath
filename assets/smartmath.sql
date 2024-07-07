-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 07 Jul 2024 pada 18.13
-- Versi server: 10.4.19-MariaDB
-- Versi PHP: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smartmath`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `kelas`
--

CREATE TABLE `kelas` (
  `id_kelas` int(11) NOT NULL,
  `nama_kelas` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kelas`
--

INSERT INTO `kelas` (`id_kelas`, `nama_kelas`) VALUES
(1, 'Kelas 10'),
(2, 'Kelas 11'),
(3, 'Kelas 12');

-- --------------------------------------------------------

--
-- Struktur dari tabel `latihan`
--

CREATE TABLE `latihan` (
  `id_latihan` int(11) NOT NULL,
  `id_kelas` int(11) NOT NULL,
  `soal` text NOT NULL,
  `option_A` varchar(100) NOT NULL,
  `option_B` varchar(100) NOT NULL,
  `option_C` varchar(100) NOT NULL,
  `option_D` varchar(100) NOT NULL,
  `option_E` varchar(100) NOT NULL,
  `answer` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `latihan`
--

INSERT INTO `latihan` (`id_latihan`, `id_kelas`, `soal`, `option_A`, `option_B`, `option_C`, `option_D`, `option_E`, `answer`) VALUES
(3, 1, '1. Hasil dari 24 x 3 + 15 : 3/4 - 7 adalah.....', 'A. 14', 'B. 15', 'C. 16', 'D. 17', 'E. 20', 'E. 20'),
(4, 1, 'Bentuk sederhana dari 24𝑎 −7 𝑏 −2𝑐 / 6𝑎−2𝑏−3𝑐−6 adalah .....\r\n', 'A. 7bc/a5', 'B. 5bc2/a5', 'C. 4bc7/a5', 'D. 4bc5/a5', 'E. 5bc7/a5', 'C. 4bc7/a5'),
(5, 1, 'Persamaan linear dalam dua variabel adalah persamaan yang dapat ditulis dalam bentuk ax+by=c, merupakan definisi dari....', 'A. persamaan linear dalam dua variabel', 'B. persamaan linear umum', 'C. persamaan linear dalam satu variabel', 'D. persamaan linear empat variabel', 'E. persamaan linear tanpa variabel', 'A. persamaan linear dalam dua variabel'),
(6, 1, 'Sebuah fungsi kuadrat diberikan oleh f(x)=3x2 + 2x - 5. Mana dari pernyataan berikut yang benar tentang fungsi ini?', 'A. Titik tertinggi fungsi ini terletak pada koordinat (2,11)', 'B. Fungsi ini memiliki dua akar real.', 'C. Diskriminan fungsi ini adalah -52.', 'D. Garis simetri fungsi ini adalah x = -1/3', 'E. Garis simetri fungsi ini adalah x = -1/4', 'B. Fungsi ini memiliki dua akar real.'),
(7, 1, 'Sebuah parabola memiliki titik puncak (3,−4) dan melalui titik (1,2). Persamaan kuadrat yang merepresentasikan parabola ini adalah:', 'A. 𝑦=2𝑥2−8𝑥+6y=2x2−8x+6', 'B. 𝑦=-2𝑥2+8𝑥−6y=-2x2+8x−6', 'C. 𝑦=2𝑥2−12𝑥+6y=2x2−12x+6', 'D. 𝑦=-2𝑥2+12𝑥−6y=-2x2+12x−6', 'E. 𝑦=-2𝑥+12𝑥−6y=-2x+10x−6', 'D. 𝑦=-2𝑥2+12𝑥−6y=-2x2+12x−6');

-- --------------------------------------------------------

--
-- Struktur dari tabel `materi`
--

CREATE TABLE `materi` (
  `id_materi` int(11) NOT NULL,
  `id_kelas` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `file_path` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `quiz`
--

CREATE TABLE `quiz` (
  `id_quiz` int(11) NOT NULL,
  `id_materi` int(11) NOT NULL,
  `questions` text NOT NULL,
  `answer` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `rating`
--

CREATE TABLE `rating` (
  `id_rating` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `rating` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `role` int(11) NOT NULL,
  `verification_code` varchar(255) DEFAULT NULL,
  `is_verified` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id_user`, `fullname`, `email`, `password`, `phone`, `address`, `role`, `verification_code`, `is_verified`) VALUES
(25, 'Rizna', 'yusmilandarizna@gmail.com', '202cb962ac59075b964b07152d234b70', '123', 'SMA 1 Padang', 2, '9895', 'verified');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_latihan`
--

CREATE TABLE `user_latihan` (
  `id_user_latihan` int(11) NOT NULL,
  `id_latihan` int(11) NOT NULL,
  `submission_data` varchar(250) NOT NULL,
  `score` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user_latihan`
--

INSERT INTO `user_latihan` (`id_user_latihan`, `id_latihan`, `submission_data`, `score`) VALUES
(66, 3, 'A. 14', '0'),
(67, 4, 'D. 4bc5/a5', '0'),
(68, 5, 'B. persamaan linear umum', '0'),
(69, 6, 'A. Titik tertinggi fungsi ini terletak pada koordinat (2,11)', '0'),
(70, 7, 'E. 𝑦=-2𝑥+12𝑥−6y=-2x+10x−6', '0'),
(71, 7, 'A. 𝑦=2𝑥2−8𝑥+6y=2x2−8x+6', '0'),
(72, 3, 'E. 20', '10'),
(73, 4, 'C. 4bc7/a5', '10'),
(74, 5, 'A. persamaan linear dalam dua variabel', '10'),
(75, 6, 'B. Fungsi ini memiliki dua akar real.', '10'),
(76, 7, 'E. 𝑦=-2𝑥+12𝑥−6y=-2x+10x−6', '0'),
(77, 7, 'A. 𝑦=2𝑥2−8𝑥+6y=2x2−8x+6', '0');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_quiz`
--

CREATE TABLE `user_quiz` (
  `id_user_quiz` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_quiz` int(11) NOT NULL,
  `submission_data` text NOT NULL,
  `score` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id_kelas`);

--
-- Indeks untuk tabel `latihan`
--
ALTER TABLE `latihan`
  ADD PRIMARY KEY (`id_latihan`);

--
-- Indeks untuk tabel `materi`
--
ALTER TABLE `materi`
  ADD PRIMARY KEY (`id_materi`);

--
-- Indeks untuk tabel `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`id_quiz`);

--
-- Indeks untuk tabel `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`id_rating`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- Indeks untuk tabel `user_latihan`
--
ALTER TABLE `user_latihan`
  ADD PRIMARY KEY (`id_user_latihan`);

--
-- Indeks untuk tabel `user_quiz`
--
ALTER TABLE `user_quiz`
  ADD PRIMARY KEY (`id_user_quiz`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id_kelas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `latihan`
--
ALTER TABLE `latihan`
  MODIFY `id_latihan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `user_latihan`
--
ALTER TABLE `user_latihan`
  MODIFY `id_user_latihan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT untuk tabel `user_quiz`
--
ALTER TABLE `user_quiz`
  MODIFY `id_user_quiz` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
