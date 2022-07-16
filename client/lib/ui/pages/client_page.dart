import 'package:build_link/data/styles/icons.dart';
import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:flutter/material.dart';

import '../../data/model/client_model.dart';
import '../widgets/space.dart';

class ClientPage extends StatefulWidget {
  final Client client;

  const ClientPage({Key? key, required this.client}) : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
      child: Column(
        children: [
          SizedBox(
            height: 48,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 32,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: AppIcon(
                    AppIcons.back,
                    color: AppColors.text,
                    size: 32,
                  ),
                ),
                Text(
                  "${widget.client.firstName} ${widget.client.lastName}",
                  style: AppTextStyles.title.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                ClientCardLabel(
                  icon: const AppIcon(AppIcons.phone, size: 24),
                  text: widget.client.phoneNumber,
                ),
                ClientCardLabel(
                  icon: const AppIcon(AppIcons.info, size: 24),
                  text: widget.client.note,
                ),
                const ClienHomes(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClientCardLabel extends StatelessWidget {
  const ClientCardLabel({Key? key, required this.icon, required this.text})
      : super(key: key);
  final Widget icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            width: 32,
            height: 32,
            child: icon,
          ),
          const Space(
            space: 12,
            orientation: Axis.horizontal,
          ),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.label.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClienHomes extends StatelessWidget {
  const ClienHomes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16),
          height: 48,
          child: Row(
            children: [
              Text(
                "Выбранные квартиры",
                style: AppTextStyles.title.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const Space(space: 24),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const AppIcon(
                  AppIcons.state,
                  size: 24,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
