import 'package:cafe_gourmet/app/data/models/endereco_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'new_endereco_user.dart';

class CardItemEnderecosUsersScreen extends StatelessWidget {
  final EnderecoModel m;
  final Function() onDelete;
  CardItemEnderecosUsersScreen({
    super.key,
    required this.m,
    required this.onDelete,
  });

  final weightCard = Get.size.width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: weightCard,
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  Get.to(
                    () => NewEnderecoUser(model: m),
                    transition: Transition.cupertino,
                  );
                },
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.orange,
                icon: Icons.edit,
                label: 'Editar',
                borderRadius: BorderRadius.circular(10.0),
              ),
              SlidableAction(
                onPressed: (c) => onDelete(),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.red,
                icon: Icons.restore_from_trash,
                label: 'Remover',
                borderRadius: BorderRadius.circular(10.0),
              ),
            ],
          ),
          child: Container(
            width: weightCard,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topCard(),
                centerCard(),
                bottomCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          m.nomeContato,
          maxLines: 2,
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            m.telefoneContato,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget centerCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, bottom: 1.0),
      child: Text(
        '${m.nomeRua}, ${m.numero}, ${m.bairro}',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 12.0,
        ),
      ),
    );
  }

  Widget bottomCard() {
    return Text(
      '${m.cidade}, ${m.estado}, ${m.cep}',
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 12.0,
      ),
    );
  }
}
