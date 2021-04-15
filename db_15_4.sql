-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Počítač: sql11.freemysqlhosting.net
-- Vytvořeno: Čtv 15. dub 2021, 18:27
-- Verze serveru: 5.5.62-0ubuntu0.14.04.1
-- Verze PHP: 7.0.33-0ubuntu0.16.04.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `sql11405906`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `filmy`
--

CREATE TABLE `filmy` (
  `id_filmu` int(11) NOT NULL,
  `nazev` varchar(75) DEFAULT NULL,
  `delka` int(11) DEFAULT NULL,
  `id_typu_filmu` int(11) NOT NULL,
  `id_zanru_filmu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `filmy`
--

INSERT INTO `filmy` (`id_filmu`, `nazev`, `delka`, `id_typu_filmu`, `id_zanru_filmu`) VALUES
(1, 'Forrest Gump', 142, 1, 1),
(2, 'Zelená míle', 188, 1, 2),
(3, 'Přelet nad kukaččím hnízdem', 133, 1, 2),
(4, 'Sedm', 127, 1, 3),
(5, 'Kmotr', 175, 1, 3),
(6, 'Terminátor 2: Den zúčtování', 137, 1, 4),
(7, 'Pán prstenů: Společenstvo Prstenu', 172, 1, 5),
(8, 'Pán prstenů: Návrat krále', 201, 1, 5),
(9, 'Vetřelec', 117, 1, 4),
(10, 'Simpsonovi ve filmu', 83, 2, 1),
(11, 'SpongeBob ve filmu: Houba na suchu', 92, 2, 1),
(12, 'Gran Torino', 116, 1, 3),
(15, '12 Opic', 124, 1, 4);

-- --------------------------------------------------------

--
-- Struktura tabulky `filmy_zeme`
--

CREATE TABLE `filmy_zeme` (
  `id_filmu` int(11) NOT NULL,
  `id_zeme` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabulky `herci`
--

CREATE TABLE `herci` (
  `id_herce` int(11) NOT NULL,
  `jmeno` varchar(45) DEFAULT NULL,
  `prijmeni` varchar(45) DEFAULT NULL,
  `datum_narozeni` date DEFAULT NULL,
  `jmeno_postavy` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `herci`
--

INSERT INTO `herci` (`id_herce`, `jmeno`, `prijmeni`, `datum_narozeni`, `jmeno_postavy`) VALUES
(7, 'Marlon', 'Brando', '1955-09-03', 'Vito Corleone'),
(8, 'Clancy', 'Brown', '1966-06-15', 'Spongebob'),
(9, 'Tom', 'Kenny', '1963-11-05', 'Sépiják'),
(10, 'Robin', 'Wright', '1966-01-23', 'Jenny'),
(11, 'Alfredo', 'Pacino', '1940-04-25', 'Michael Corleone'),
(12, 'Tom', 'Hanks', '1955-05-31', 'Forrest Gump');

-- --------------------------------------------------------

--
-- Struktura tabulky `herci_filmy`
--

CREATE TABLE `herci_filmy` (
  `id_herce` int(11) NOT NULL,
  `id_filmu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabulky `jazyky`
--

CREATE TABLE `jazyky` (
  `id_jazyku` int(11) NOT NULL,
  `nazev` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `jazyky`
--

INSERT INTO `jazyky` (`id_jazyku`, `nazev`) VALUES
(1, 'Čeština'),
(2, 'Angličtina'),
(3, 'Francouzština');

-- --------------------------------------------------------

--
-- Struktura tabulky `jazyky_filmy`
--

CREATE TABLE `jazyky_filmy` (
  `id_jazyku` int(11) NOT NULL,
  `id_filmu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabulky `prodeje`
--

CREATE TABLE `prodeje` (
  `id_prodeje` int(11) NOT NULL,
  `cas_prodeje` datetime DEFAULT NULL,
  `cena_vstupenky` smallint(6) DEFAULT NULL,
  `misto_v_sale` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `prodeje`
--

INSERT INTO `prodeje` (`id_prodeje`, `cas_prodeje`, `cena_vstupenky`, `misto_v_sale`) VALUES
(33, '0000-00-00 00:00:00', 150, 512),
(34, '0000-00-00 00:00:00', 150, 416),
(35, '0000-00-00 00:00:00', 150, 819),
(36, '0000-00-00 00:00:00', 150, 815),
(37, '0000-00-00 00:00:00', 150, 616),
(38, '0000-00-00 00:00:00', 250, 201),
(39, '0000-00-00 00:00:00', 250, 609),
(40, '0000-00-00 00:00:00', 250, 525),
(41, '0000-00-00 00:00:00', 250, 225),
(42, '0000-00-00 00:00:00', 250, 623),
(43, '0000-00-00 00:00:00', 250, 714),
(44, '0000-00-00 00:00:00', 100, 113),
(45, '0000-00-00 00:00:00', 100, 823),
(46, '0000-00-00 00:00:00', 100, 608),
(47, '0000-00-00 00:00:00', 100, 621),
(48, '0000-00-00 00:00:00', 100, 613);

-- --------------------------------------------------------

--
-- Struktura tabulky `promitani`
--

CREATE TABLE `promitani` (
  `id_promitani` int(11) NOT NULL,
  `cas` time DEFAULT NULL,
  `datum_promitani` date DEFAULT NULL,
  `id_filmy` int(11) NOT NULL,
  `id_prodeje` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `promitani`
--

INSERT INTO `promitani` (`id_promitani`, `cas`, `datum_promitani`, `id_filmy`, `id_prodeje`) VALUES
(1, '12:00:00', '2019-01-01', 1, 1);

-- --------------------------------------------------------

--
-- Struktura tabulky `saly`
--

CREATE TABLE `saly` (
  `id_salu` int(11) NOT NULL,
  `cislo_salu` int(11) DEFAULT NULL,
  `typ_promitani` tinyint(1) DEFAULT NULL,
  `typ_ozvuceni` tinyint(1) DEFAULT NULL,
  `id_promitani` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `saly`
--

INSERT INTO `saly` (`id_salu`, `cislo_salu`, `typ_promitani`, `typ_ozvuceni`, `id_promitani`) VALUES
(1, 1, 1, 1, 1),
(2, 2, 0, 1, 2),
(3, 3, 0, 0, 3);

-- --------------------------------------------------------

--
-- Struktura tabulky `typy_filmu`
--

CREATE TABLE `typy_filmu` (
  `id_typu` int(11) NOT NULL,
  `typ_filmu` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `typy_filmu`
--

INSERT INTO `typy_filmu` (`id_typu`, `typ_filmu`) VALUES
(1, 'Hraný'),
(2, 'Animovaný');

-- --------------------------------------------------------

--
-- Struktura tabulky `uzivatele`
--

CREATE TABLE `uzivatele` (
  `id_uzivatele` int(11) NOT NULL,
  `jmeno` varchar(40) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `heslo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `uzivatele`
--

INSERT INTO `uzivatele` (`id_uzivatele`, `jmeno`, `email`, `heslo`) VALUES
(2, 'radek', 'jestrabikr@gmail.com', '$2b$12$/ATGozDPqNfom1AeywOZXO99.JpvlSZoca2VU9BarAulcZYQ1oTje'),
(4, 'admin', 'admin@admin.com', '$2b$12$4kUL0oGPKkDrhBBg78y4IO6khrc3yifrDRvh8zER/8HE92tKhKHla'),
(5, '', '', '$2b$12$EbZQU/TGh.I5MZ2xHxQXt.8vod1Fcide9Be74vukPHvo3ZyAv3Lq6'),
(6, '', '', '$2b$12$UjTF1kKZQlM9Ap3UGK5Hj..J7J5ohU8Q8niNurPzc/4rRlmb7Za6q'),
(7, '', '', '$2b$12$dIpOi4vcdrYBpdDjL8Atye05aGp2E1/IH7bejSHc4wgmmw8qDDQrS'),
(8, '', '', '$2b$12$uvEzhs.P07IzQqQtJ.hHYumVy76bEPr25TSio2h8Bn5.0M76FI/VW');

-- --------------------------------------------------------

--
-- Struktura tabulky `zanry_filmu`
--

CREATE TABLE `zanry_filmu` (
  `id_zanru` int(11) NOT NULL,
  `nazev_zanru` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `zanry_filmu`
--

INSERT INTO `zanry_filmu` (`id_zanru`, `nazev_zanru`) VALUES
(1, 'Komedie'),
(2, 'Drama'),
(3, 'Krimi'),
(4, 'Sci-Fi'),
(5, 'Fantasy');

-- --------------------------------------------------------

--
-- Struktura tabulky `zeme`
--

CREATE TABLE `zeme` (
  `id_zeme` int(11) NOT NULL,
  `nazev_zeme` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `zeme`
--

INSERT INTO `zeme` (`id_zeme`, `nazev_zeme`) VALUES
(1, 'USA'),
(2, 'Francie'),
(3, 'Nový Zéland'),
(4, 'Velká Británie');

--
-- Klíče pro exportované tabulky
--

--
-- Klíče pro tabulku `filmy`
--
ALTER TABLE `filmy`
  ADD PRIMARY KEY (`id_filmu`);

--
-- Klíče pro tabulku `filmy_zeme`
--
ALTER TABLE `filmy_zeme`
  ADD PRIMARY KEY (`id_filmu`,`id_zeme`);

--
-- Klíče pro tabulku `herci`
--
ALTER TABLE `herci`
  ADD PRIMARY KEY (`id_herce`);

--
-- Klíče pro tabulku `herci_filmy`
--
ALTER TABLE `herci_filmy`
  ADD PRIMARY KEY (`id_herce`,`id_filmu`);

--
-- Klíče pro tabulku `jazyky`
--
ALTER TABLE `jazyky`
  ADD PRIMARY KEY (`id_jazyku`);

--
-- Klíče pro tabulku `jazyky_filmy`
--
ALTER TABLE `jazyky_filmy`
  ADD PRIMARY KEY (`id_jazyku`,`id_filmu`);

--
-- Klíče pro tabulku `prodeje`
--
ALTER TABLE `prodeje`
  ADD PRIMARY KEY (`id_prodeje`);

--
-- Klíče pro tabulku `promitani`
--
ALTER TABLE `promitani`
  ADD PRIMARY KEY (`id_promitani`);

--
-- Klíče pro tabulku `saly`
--
ALTER TABLE `saly`
  ADD PRIMARY KEY (`id_salu`,`id_promitani`);

--
-- Klíče pro tabulku `typy_filmu`
--
ALTER TABLE `typy_filmu`
  ADD PRIMARY KEY (`id_typu`);

--
-- Klíče pro tabulku `uzivatele`
--
ALTER TABLE `uzivatele`
  ADD PRIMARY KEY (`id_uzivatele`);

--
-- Klíče pro tabulku `zanry_filmu`
--
ALTER TABLE `zanry_filmu`
  ADD PRIMARY KEY (`id_zanru`);

--
-- Klíče pro tabulku `zeme`
--
ALTER TABLE `zeme`
  ADD PRIMARY KEY (`id_zeme`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `filmy`
--
ALTER TABLE `filmy`
  MODIFY `id_filmu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT pro tabulku `herci`
--
ALTER TABLE `herci`
  MODIFY `id_herce` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT pro tabulku `jazyky`
--
ALTER TABLE `jazyky`
  MODIFY `id_jazyku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pro tabulku `prodeje`
--
ALTER TABLE `prodeje`
  MODIFY `id_prodeje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT pro tabulku `promitani`
--
ALTER TABLE `promitani`
  MODIFY `id_promitani` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pro tabulku `saly`
--
ALTER TABLE `saly`
  MODIFY `id_salu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pro tabulku `typy_filmu`
--
ALTER TABLE `typy_filmu`
  MODIFY `id_typu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pro tabulku `uzivatele`
--
ALTER TABLE `uzivatele`
  MODIFY `id_uzivatele` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT pro tabulku `zanry_filmu`
--
ALTER TABLE `zanry_filmu`
  MODIFY `id_zanru` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pro tabulku `zeme`
--
ALTER TABLE `zeme`
  MODIFY `id_zeme` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
