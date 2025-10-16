import 'package:fedman_admin_app/core/common_widgets/responsive_row_column.dart';
import 'package:fedman_admin_app/core/navigation/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fedman_admin_app/core/extensions/space.dart';
import 'package:fedman_admin_app/core/theme/app_text_styles.dart';
import 'package:fedman_admin_app/core/constants/app_colors.dart';
import 'package:fedman_admin_app/core/common_widgets/retry_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../blocs/descipline_bloc/discipline_bloc.dart';
import '../../data/repositories/discipline_repo.dart';
import 'level_card.dart';

class DisciplineDetailDialog extends StatelessWidget {
  final int disciplineId;

  const DisciplineDetailDialog({
    super.key,
    required this.disciplineId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DisciplineBloc(
        disciplineRepo: GetIt.I<DisciplineRepo>(),
      )..add(GetDisciplineRequested(disciplineId: disciplineId)),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(

          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BlocBuilder<DisciplineBloc, DisciplineState>(
                      builder: (context, state) {
                        if (state is DisciplineLoaded) {
                          return Text(
                            state.discipline.name,
                            style: AppTextStyles.heading2,
                            overflow: TextOverflow.ellipsis,
                          );
                        }
                        return Text(
                          'Loading...',
                          style: AppTextStyles.heading2,
                        );
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.go(RouteName.disciplines),
                    icon: const Icon(Icons.close),
                    color: AppColors.greyColor,
                  ),
                ],
              ),
              24.verticalSpace,
              Expanded(
                child: BlocBuilder<DisciplineBloc, DisciplineState>(
                  builder: (context, state) {
                    if (state is DisciplineLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is DisciplineError) {
                      return Center(
                        child: RetryWidget(
                          message: state.message,
                          onTapOnRetry: () {
                            context.read<DisciplineBloc>().add(
                              GetDisciplineRequested(disciplineId: disciplineId),
                            );
                          },
                        ),
                      );
                    } else if (state is DisciplineLoaded) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            if (state.discipline.levels.isNotEmpty) ...[

                              Wrap(spacing: 20,runSpacing: 20,children: List.generate(state.discipline.levels.length, (index) {
                                final level = state.discipline.levels[index];
                                return LevelCard(level: level);
                              },),),
                      //   GridView.builder(
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      //     ///height
                      //     mainAxisExtent: ResponsiveHelper.responsiveValue(context, mobile:220,tablet:220, desktop: 400, ) ,
                      //     ///width
                      //     maxCrossAxisExtent: ResponsiveHelper.responsiveValue(context, mobile:520, tablet:320,desktop: 500, ) ,
                      //     crossAxisSpacing: 8,
                      //     mainAxisSpacing: 16,
                      //   ),
                      //   itemCount: state.discipline.levels.length,
                      //   itemBuilder: (context, index) {
                      //     final discipline = state.discipline.levels[index];
                      //     return LevelCard(level: state.discipline.levels[index]);
                      //   },
                      // ),
                      //         ...state.discipline.levels.map((level) =>
                      //           Padding(
                      //             padding: const EdgeInsets.only(bottom: 24),
                      //             child: LevelCard(level: level),
                      //           ),
                         //     ),
                            ] else ...[
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(32),
                                  child: Text(
                                    'No levels found for this discipline',
                                    style: AppTextStyles.body1.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}