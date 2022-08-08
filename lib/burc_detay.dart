import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'model/burc.dart';

class BurcDetay extends StatefulWidget {
  final Burc secilenBurc;
  const BurcDetay({required this.secilenBurc, Key? key}) : super(key: key);

  @override
  State<BurcDetay> createState() => _BurcDetayState();
}

class _BurcDetayState extends State<BurcDetay> {
  Color appbarRengi = Colors.transparent;
  late PaletteGenerator _generator;

  @override
  void initState() {
    super.initState();
    print('init state çalıştı');
    WidgetsBinding.instance.addPostFrameCallback((_)=> appbarRenginiBul());
    //Yukarıdaki yapı şu işe yarar;
    //İlk önce bir built yapsın diyor sistem appBarRenginiBul çalışmış ve bitmiştir
    //o bittikten sonra işlemlerimizi yapıp set state'i bir daha çalıştırmış oluyoruz.
    // _generator = PaletteGenerator.fromImageProvider(AssetImage(assetName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          backgroundColor: appbarRengi,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(widget.secilenBurc.burcAdi + " Burcu Ve Özellikleri"),
            centerTitle: true,
            background: Image.asset(
                'images/' + widget.secilenBurc.burcBuyukResim,
                fit: BoxFit.cover),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Text(widget.secilenBurc.burcDetayi,
                  style: Theme.of(context).textTheme.subtitle1),
            ),
          ),
        ),
      ],
    ));
  }

  void appbarRenginiBul() async {
    print('Build bitti, baskın renk bulunacak...');
    _generator = await PaletteGenerator.fromImageProvider(AssetImage('images/${widget.secilenBurc.burcBuyukResim}'));
    appbarRengi=_generator.dominantColor!.color;
    print('Baskın renk bulundu, build metodu tekrar çalıştırılacak');
    setState(() {
      
    });
    print(appbarRengi);
  }
}
