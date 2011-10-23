use strict;
use warnings;
use Test::More;
use Digest::Groestl qw(groestl_512 groestl_512_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::Groestl->new(512)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            groestl_512_hex($data), $digest,
            "groestl_512_hex: $len bits of $msg"
        );
        ok(
            groestl_512($data) eq pack('H*', $digest),
            "groestl_512: $len bits of $msg"
        );
    }

    my $md = Digest::Groestl->new(512)->add_bits($data, $len)->hexdigest;
    is($md, $digest, "new/add_bits/hexdigest: $len bits of $msg");
}
continue { $len++ }

done_testing;

__DATA__
00|6d3ad29d279110eef3adbd66de2a0345a77baede1557f5d099fce0c03d6dc2ba8e6d4a6633dfbd66053c20faa87d1a11f39a7fbe4a6c2f009801370308fc4ad8
00|1b09b54f197a0539dbb9c3936bb4cc00fae65d1446a30529cfcb18f24acca7ba17b6a4e4b514ddd8739106d016df2de4cdd6b341de23fb597aeba22b34a16c38
C0|fb084f886e72d5556de8dd85ccbed62d635146fcb48f518b3c7f12398871cf55cd2efd914d775ebe69c427c21c8c7682d7ba807c46ab1ab1cf857c128f75a49d
C0|de9685b3ecc8b0f8f3e95960130a3e799bc3c05facc2744b743b50fd694c3ea619d310ee8d21e3b5c31005431ac0704cde192e382d9151c117264ad6c19ea68a
80|fa6879857048aff3b120506baeaa62ac3a12f916bbc1ed2cb9237bc56ba263033f19411a1c142b3f2b437e0371814808888bde7904ea9a85faeee6b996fd341b
48|af564554dcf79ceac23439475e7d905be88066d0a4e5b198273656e6dccb6a4cce23c19e6a963c2be326256e463094eb8f72f39c35984a2ef9ec3c76232f2a3c
50|0048af524191e63727d849a86bbeb25e4bb074257b7f041a6ed922819bb6ab8141d6992c5e75010e22eb91b776622fa043c88025e3aae6da7ba4abf9ea9a26f3
98|46523ea86464de469c1cc702b04266447f918cd8452d4d3d687c908c0e237dad51981564fcf9b860c83301c5f4750f47f44ac273001257c50f4185507983d34d
CC|b23eeeb675c272c6e37a6ee9ab4dc505c9d6a10020f6bed3948205d04cdd1e90b06e494d186ef4f19266d7da200c89dc009e2b1a538cdea199e773fc076f802e
9800|f027d0928297474ff8b09d3f0f68911a8d589e5b570797e6fd09c53dea7d908d77a72922b80dc93cdbc612b5c1342c7eee9395e6de11352cb607242955b7c748
9D40|a6e1217acccf903564910ae0985b4b3bd28c31e09dbb7ba1e766f3ee318450489d8538a96791efcd8312945344e68e17187a2905a4b3e290d747f9033b84f5c6
AA80|9c576d14adea3195b0aadd813a92f3e3af916c604e4ab1cc790e08a22d7ce5bb78e2a2c29e87cf26c5627932b21456394670fd6de8a7fe77965c0860dd7cbb58
9830|2641419789602abcf74f4b4b8b886dfa37e8846f61b7ac627dc5bf268c3f166107da0ef7aa9f912200ccfe4674755c5aeea2e8a06ff83a865850970fee2f65e8
5030|0892ecd8916c5151df9a07855640a958914668a49ecf2101e9eed53a1440af11698f45b52ba0a6fa76568eb86971eac747770f96b121714da9ba74b551b94df2
4D24|de485dbdb98d94d4c12980b37b8077636758279da75671e1f904747b9c83b0aaca9620d086bd976a138ad66fd066f22ac69bd060751dcd29c9e3260e877a6872
CBDE|de24b56de555ca938716225bd7d33167debfff390e5f83878ed67fab054ddac87701ab64f1feef30d4ced2d1991c3ddd8aaa38b464f1a388854f6075b3e9e741
41FB|272ba3fd8a6e392278f234e5053411e8267375a4f9b05d960afd2e664a67448f500f8bcdd5b8a68d0bddf3baf873cddde5c235943c58353ad90aed79a6c39cf3
4FF400|13b42bf017644138341c1f21fa6adc5ed608e8e9ac9c37431a5be53765537b466d7019f78e246860ad5310b9c6fbe4ed6059cc6498cdaedf76f23529afb7a28b
FD0440|f1094bc6e4ff6588819a34e669508d6d879c06d40114c460cfff95637e52923a0ea9b92f69cad9bc105e341915b053c8673b77728390805786a93a7cf8a601bf
424D00|6f82a8f0e1c3e1ac0608dc67c9e00dfe3b485866239efb34372de464806a3d0fac1d2cb372cbcdea9bb8af1e01e6f47ebbbe39ff55ebb6a48e7bf42ada6e73eb
3FDEE0|8f935f18008c1182902e3ef5909f7704df5c86dc5e8e2023014b6a1be2eb851e8e013739a092a899f6fa1e928394244d18ecbdd98ba5619fa98c9b68f4cc14f1
335768|a54888806312428bd6344bcba65802b3d1729b1868904237dd70082078951349a1cb5bd555d869f30fc972a544fc742116b2a54a08289d2c24c1542efd25704d
051E7C|70fe13fabfecb8b124d01e81d2bdbaf523e8b4183025143cfa10b07dddc56603017e9cba0e89a6c9e851d8e7580a3ce47e308d98427ed73d43efba39372362a5
717F8C|9f7808d276f932101517c3a13e798beb3e9dadde1740ba69252cad5387cc715249e4e33891a364ffc9bef23f9cab095af2de1876b14cfd2aec443fa042514933
1F877C|413907c17d8ca9e5477de5491914dc4eb621f35c96267f8e807affc0335dd8f6781c053ced249ff3c8c5a4d4ac62fe3d9e6660b30cc09621de7162e6c271d3c7
EB35CF80|6f28517124ec8da8c2bdfeddef6b2578905aed34fc6c52c3f33b6ca1d600825cb2fcdd87ab1cca7010d554a143dcfa05a3fa273c434c9952d5708dae947dbe81
B406C480|0a1650ff23cea1d64b7173e58b92aa3bc24e2fb74892d11ae4235f8329e6399829a0e6adbbc422910294b92fa27bce4fe88a7e4ff41c2b5be87c10b25cc70a35
CEE88040|a2421345150dcec67c78026b98510de244c1f653d5d9c7f6b073e85eb5ec4fd3e15e5782e7d2ce9767a0bd662a5e51a0372fb50263b72373caa5e14b72540ae9
C584DB70|d1d114bfdafda451a3b986ce6faeafa6ef92daf109372fd7856d81cf4f55d64f58a7f1fdc0737a128230866b4dc52d68a58e78a36f59123ce7344be1e7f72bc4
53587BC8|1bfe6e7e0ef04eda071babe16f2979c58371e73d67dce7083d85d5c3087ca12ade24977fbc7ea62b74390feddc6820999f974b9e8422e4b4c17bf9477f967d13
69A305B0|5f920c73aeb9201668cfe28eb9e202a97771e3a1acf3b1e7c93d4ef3e002f9bc820fbe6f8164fcafb41e256bf35b85ce432f15d9c03cb58cb8303e6b4b4d6b7d
C9375ECE|b03d3f7245fccf45fb446113d2460affb0837cb9dae0b09091d3015424f818b32af0877d8db22b1817e06daaa4b9abc5513b1a3da72e9dd44e3632fbdde43f19
C1ECFDFC|4726d760203c1eaf847f6837c74c16adcef5b55ead5768a7c13e21a33d0d7b740f52de8c81356da63daba791da6680af015deb81246550201f232822bb087ce5
8D73E8A280|4d8007ee4413dc15ff875b4c5f1c6e8badcbcfca4d2dda70a50e9027c1fda460096f630f3cd28d117c4f16b2d6a2aae692f12de062f387d9e4f4ecb403bad153
06F2522080|75d378c495d7213b2a087f6da40276d264e3f57b03af1cb5e65e0d765094a40e4328237714122dd82450ebdf1e4f1ca9eae028afa1a24826b247e481b9bdfbfb
3EF6C36F20|0252a1ab24ab5d5713ebfb4969186b3c3afe870f512ef8e1773fa32591d16d2fd4aeec2af15c87e48326d13aeabb2dc2ddfdfa9c847b3b274c641e2d4d690b9d
0127A1D340|5e6946fbf2b38c394ef430b16ef7a8628ed5ca907099588a2ea1cdececaa04e4cce0eff54c4cdb187945d2fae9f5f3585152d8ae2c052d1067631d4548a2c019
6A6AB6C210|606f7d0a73b712450682fa0e2cee6e554deba2ebfadfe8f8b3dcb4db278ac197bd7e81f7a55ada3ad9c2623ef1f8a856c82144636b61fefde87596460c08a0ac
AF3175E160|ab9f5e9b20022e5bfa3132dd1f09f1cd988e82e33a668dcf2b0f9a87481fde8d9657f7ac4fc65e640d79d8765498586116aa4bf1195ee275a4891236e2ebef58
B66609ED86|4541f542e83c7c7db901daab9e0927768c56a7880e9c5f5483b597d65c3ff6121d286dc8ea9fb439c58dd3d7b62930487bbbc2d7f3b30be6e9bbe027d8b7de74
21F134AC57|9cbd9bdc5786ee3e8bda3960ddc89cfd41b2bebd1f42b9a16b390d15026db6bf817c81c079906c2f4810a8b5cc5df5d80aeafa8247a9ca47d45fd2f018e7df05
3DC2AADFFC80|566383e9ffd79a817d8c4eeb45a743920d329ade2f93de0a222f220d61b75b9a12d6d7e4e3aa02d7dd7bcadea93030bc7f6001b0c8ced161c476d7a78ae235b3
9202736D2240|308e0342a706e03a50575637703e436b8405a228c147a8c25e5a234da7e057b9cba1cf84423f2b06a05047b2ebb8b960769a9cbaf5479087c07a33c037331bd4
F219BD629820|2c40110d97f29d504890d8b9b58385d09b5658dab9f5aa140c7e3a866731bb8e4eda299d730616ffead5e6ff58645b244a498407ba38ac1d8650758a1e5fa913
F3511EE2C4B0|8b0d8f3a928dd821d0310ed8e5889c647c794f52b60a935214883d362c8d2bf659959a4519e32658359e48355993f36197a2179523f1238c9647f8d568a2d3f8
3ECAB6BF7720|b3a3d0b69d6e0e688292998102e52a62401690c4072df99e8e495a462634ac27ac51ad8ba2db7ed7018b9fb3e97dfc1796dcc024f9339f35c0856170597f6a28
CD62F688F498|8d3a7c10db7d3f3789fded9742dec8216b1fc65a0c5617ed17736a9b9b2f097c95e52286c3f0a59ce6768c81a350260d84fd4660cf13ce87020b17b858da3ae9
C2CBAA33A9F8|7cedd75f661a0a874e2ba3bd06bbb4c450f452c273ef195a5ccab81d192826a4c59fb019031160af4df18795036bb5ed242957b3cad16bd8c3c9107d9193250d
C6F50BB74E29|e44a8d25cf351f81aebaf5a0fcc464c22778813b998268bb422b58c7147f5bfd021302db33236344bedcfe83485171bb2c3707628938a9ef7c1918e0ef95bb23
79F1B4CCC62A00|a43b7f7015ed89a10bd28a2eb513a02f03b81242e480d3c6a3f89de2914c8f75ff7c090d84e57c6fa9bb34628a0d48084cf7b7f6bf0e279c321c359808f397c3
