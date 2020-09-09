part of 'screens.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          bottom: TabBar(
            indicatorColor: whiteColor,
            tabs: <Widget>[
              Tab(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(MdiIcons.viewList),
                  SizedBox(width: 10),
                  Text('Informasi', style: TextStyle(fontSize: 18)),
                ],
              )),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(MdiIcons.castEducation),
                    SizedBox(width: 10),
                    Text('Edukasi', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            //Informasi
            Container(
              width: SizeConfig.defaultWidth,
              height: SizeConfig.defaultHeight,
              color: whiteColor,
              padding: EdgeInsets.only(bottom: 70.0),
              child: RefreshIndicator(
                color: mainColor,
                onRefresh: refreshInformasi,
                child: BlocBuilder<InformasiBloc, InformasiState>(
                    builder: (_, informasiState) {
                  if (informasiState is InformasiLoaded) {
                    List<Informasi> informasi = informasiState.informasi;
                    if (informasi == null ||
                        informasi.isEmpty ||
                        informasi == []) {
                      return noDataYet('Informasi');
                    }
                    return ListView.builder(
                        itemCount: informasi.length,
                        itemBuilder: (context, i) {
                          return CardCustomInformasi(
                            informasi: informasi[i],
                            onTap: () {},
                          );
                        });
                  } else {
                    return LoadingShimmerInfo();
                  }
                }),
              ),
            ),
            //Edukasi
            Container(
              width: SizeConfig.defaultWidth,
              height: SizeConfig.defaultHeight,
              color: whiteColor,
              padding: EdgeInsets.only(bottom: 70.0),
              child: RefreshIndicator(
                color: mainColor,
                onRefresh: refreshEdukasi,
                child: BlocBuilder<EdukasiBloc, EdukasiState>(
                  builder: (_, edukasiState) {
                    if (edukasiState is EdukasiLoaded) {
                      List<Edukasi> edukasi = edukasiState.edukasi;
                      if (edukasi == null || edukasi.isEmpty || edukasi == []) {
                        return noDataYet('Edukasi');
                      }
                      return ListView.builder(
                          itemCount: edukasi.length,
                          itemBuilder: (context, i) {
                            return EdukasiCard(
                              edukasi: edukasi[i],
                              onTap: () {},
                            );
                          });
                    } else {
                      return LoadingShimmerEdukasi();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> refreshInformasi() async {
    context.bloc<InformasiBloc>().add(FetchInformasi());
    await Future.delayed(Duration(seconds: 2));
  }

  Future<Null> refreshEdukasi() async {
    context.bloc<EdukasiBloc>().add(FetchEdukasi());
    await Future.delayed(Duration(seconds: 2));
  }
}
