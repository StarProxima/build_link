
import 'package:build_link/data/model/client_model.dart';
import 'package:build_link/data/repositories/house_repository.dart';
import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/ui/pages/client_page.dart';
import 'package:build_link/ui/widgets/client_card_widget.dart';
import 'package:flutter/material.dart';

class ClientsPage extends StatefulWidget {
  final int agentID;
  const ClientsPage({Key? key, required this.agentID}) : super(key: key);

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  late List<Client> clients = [];
  final double minCardWidth = 360;
  @override
  void initState() {
    super.initState();

    HouseRepository.getClients(widget.agentID).then((value) {
      setState(() {
        clients = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        var size = Size(constraints.maxWidth, constraints.maxHeight);
        var columnsCount = 2;
        // if (size.width < minCardWidth * 2 + 48 + 16) {
        //   columnsCount = 1;
        // } else if (size.width < minCardWidth * 3 + 48 + 32) {
        //   columnsCount = 2;
        // } else {
        //   columnsCount = 3;
        // }
        var itemWidth = ((size.width - 32) / columnsCount).floor() - 16;

        return Container(
          padding: const EdgeInsets.all(24),
          color: AppColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 48,
                child: Text(
                  "Мои клиенты",
                  style: AppFontStyles.title.copyWith(
                    color: AppColors.text,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnsCount,
                    childAspectRatio: itemWidth / (188.0),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    return ClientCardWidget(
                      client: clients[index],
                      onPress: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) {
                                return ClientPage(client: clients[index]);
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child,) {
                                const begin = Offset(0.0, 1.0);
                                const end = Offset.zero;
                                final tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: Curves.easeOut));
                                final offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );

                                //return child;
                              },
                            ),);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
