import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/bordered_container.dart';
import 'package:go_router/go_router.dart';

class MarketMissionCard extends StatelessWidget {
  final String imageUrl;
  final String marketName;
  final String productCount;
  final String points;
  final String marketId;

  const MarketMissionCard({
    super.key,
    required this.imageUrl,
    required this.marketName,
    required this.productCount,
    required this.points,
    required this.marketId
  });

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      backgroundColor: AppColors.bgTerciary,
      borderColor: AppColors.borderAccent,
      borderWidth: 1,
      child: InkWell(
        onTap: () => context.push('/scout/missions'),//$marketId TODO
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 20, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Textos
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 15, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      marketName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          productCount,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          points,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary,
                          )
                        )
                      ]
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}