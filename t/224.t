use strict;
use warnings;
use Test::More tests => 68;
use Digest::Groestl qw(groestl_224 groestl_224_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::Groestl->new(224)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            groestl_224_hex($data), $digest,
            "groestl_224_hex: $len bits of $msg"
        );
        ok(
            groestl_224($data) eq pack('H*', $digest),
            "groestl_224: $len bits of $msg"
        );
    }

    my $md = Digest::Groestl->new(224)->add_bits($data, $len)->hexdigest;
    is($md, $digest, "new/add_bits/hexdigest: $msg");
}
continue { $len++ }

__DATA__
00|07F3750F4831D8AD1763CD46AB6B40C6C49F1CDCC78BB64F8D40C7DF
00|F1CDA2D47B40BCA84ACCE069DD588158BE18261EC94950153EA932B0
C0|987F70F580932501B2E94D9559FF3526AD99AA51539A44DD3A0697D8
C0|551528A4BA8D778B471B1E8DDE3A22471FFE7589780410A16C111516
80|28B234EF25BB3B9D4590CFAFFF7BE4892422E9DA12A2497E1E219810
48|F5DFF8FB1184D511CACC4A6EDFEFB22A8361D234CCCFDA78C077E654
50|D70DAAE4A0C58D867714C782DD03762D34CD10B68D551F435CACC1CE
98|C33727C5CEAF2A76941C173EB8E20E505989D268BC09E6DC6EE7821A
CC|F1E0031F8791440EBC3B0CC4490540CA337D939D77659BEF74D4FB48
9800|56C4C96223A96D79F12583F7C0C56826C990B453ECA653ED00E1E253
9D40|832D97F671A7E6AC79B59679152AA926C6BECC91973FC535B9B43C9B
AA80|7F12F389AD88CEB13B55DB050C8CE13E37B6405DAAFA512DCEAE8599
9830|E1709AD230C5180150207CE3553D7F628E7BEE81BFE7E8C9E33CAE8A
5030|391A7EB04485ACB0BD32B3DCB0639B25BCA8ADE5AE811E113A8F6749
4D24|2D635AE63671E79BBA0FC9A8A60BF6270FE60402294A3F0AD1BFC717
CBDE|53CB8E853CB562CA6C45A8277F894BBA0ADFE519476B3EFC4D041FED
41FB|E6D01E5C14B41A884F189BF1B79E7B7CDB04DA3DAE0B4B50CCC209C6
4FF400|41C21C66AA01BDF6DC12DF62C13A745C2011B138F85B376B16B6482A
FD0440|99A4B4BDFF12817522A3118593E46F9A85E7B642D8782567B9DA8BDD
424D00|5E7DF0BD5BF6B7088D26A1CE238DAB5904A89144B38B652092EAEE91
3FDEE0|4B902DD7DD29719A81CB70FB27F0D0C5DD398589869AF70FFB46978C
335768|9D8C0A8E3F07FF165DA5AD0E35FB433735E65A643B14A002A4C8DCF6
051E7C|50EC509412315ECB9EF672C994A8147BF3704A710A519E9703F1685E
717F8C|550A4786124BE05D470F0256C468CE7FFD13F624936A706BF8367F10
1F877C|9DF301A7FA07F23B19221392BF9C1BBC10C4BE593C786FF9555FA286
EB35CF80|214416DB7B6C394A78A63E78B4C78D4A2F05C503C7BA7E88FC759482
B406C480|0DDC4ED37F472FF28A34240028A77FF4E3C662CAC934C577EDFE1CAA
CEE88040|C8A2E21DE6F4C1B7B6D245347B138BE27A08200562C115B1A8887871
C584DB70|741BAD32285285F12DCD5C9AAE1282C1A2FC670C46F5E4AA99F5AD8B
53587BC8|0B39E5307425DE78E276D7C0F3654E829C867A1873DD8504BAA1A486
69A305B0|B0B117AE3F414BD769410C8AEA0FBD83979E546F17D68B2740949116
C9375ECE|D1303BB1322856EA943AEE619AAC7DD8660D04337D40553B8C464CEE
C1ECFDFC|768555951BCC867B4BCEF2895390480533F6F541DD9D8536351C1696
8D73E8A280|0C1258CB3B4FA553E0F2E156593CEAF99363002E918F123C586B7D69
06F2522080|B924AD9D40E704B3EAC027A4D0758DBB21E2F1D7A61CD03AC26534C5
3EF6C36F20|255572BCD08EE3309A5A56C021BAE436CEC9521888746A89EBF075F2
0127A1D340|F3BE2F0BACAF24C123D990DC223B0682CE300F63A2223CCF6A092DDC
6A6AB6C210|997A8594F166801B86B4273C9FBB1CF10F25889C66C86EDEF8901ABC
AF3175E160|12A7D944F59330788A0CD976A1D1CA36AA88CA7F86535788D717C4EC
B66609ED86|2A846AA2A16B14827F4FBB1B6A0FF2CFCECDA78CD313570BA2C30F70
21F134AC57|A78AA91A21D78D95095C9BB5702FDE5AFC378B9FE929067DB8015301
3DC2AADFFC80|651F8DA6A518D6FAA6001023E723E58C5B8F13B3BFCBD5895119C8BB
9202736D2240|5A6AFFDF296E44F6069C4883B4E995A429930190A69785A293F5FF15
F219BD629820|CE8D22C095C6B204DBEE9847261363FA6427EF43D2227C04BDB363E2
F3511EE2C4B0|F595753006A529164A22152BFDCF41533F3E5B4313F31EF3526395BB
3ECAB6BF7720|A8190F0B6D940944D12233D9BA5B8DFE5CEDD029E0353E5FB14DC584
CD62F688F498|078049EF2DDC32B2C2A26C871F6432485D636EF9BD3E6DFBA9DA1D3D
C2CBAA33A9F8|9EB24751242388BA40783623976A8C8C458EE4B523D43AD43ED7F077
C6F50BB74E29|616393DC7C4B6E00FEF916F9545611BFDA3B82D91014C930110D5A90
79F1B4CCC62A00|DC8075A6C464563558E8DED02667DE78938BF1182A2D882503DF4792
