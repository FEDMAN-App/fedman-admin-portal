
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../../core/common_widgets/custom_text_form_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bloc/country_bloc.dart';

class CityDropdownView extends StatefulWidget {
  final String? title;
  final String hintText;

  final Function(String?)? onCitySelected;
  final String? Function(String?)? validator;
 final String? selectedCity;
  final ExpansibleController? cityExpansionController;


  const CityDropdownView({
    super.key,
    this.title,
    required this.hintText,

    this.onCitySelected,
    this.validator,
    this.selectedCity,
    this.cityExpansionController

  });

  @override
  State<CityDropdownView> createState() => _CityDropdownViewState();
}

class _CityDropdownViewState extends State<CityDropdownView> {
  String? _selectedCity;
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredCities = [];
  late ExpansibleController? cityExpansionController;

  @override
  void initState() {
    super.initState();
        _selectedCity=widget.selectedCity;
    _searchController.addListener(_onSearchChanged);

    if(widget.cityExpansionController == null){
      cityExpansionController=ExpansibleController();
    }else{
      cityExpansionController=widget.cityExpansionController;
    }
  }

  @override
  void didUpdateWidget(CityDropdownView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedCity=widget.selectedCity;
    // if(context
    //     .read<CountryBloc>()
    //     .availableCountries != null){
    //   final cities = context
    //       .read<CountryBloc>()
    //       .availableCountries!.firstWhere(
    //         (element) =>
    //     element.country ==
    //         context.read<CountryBloc>().selectedCountry!.country,
    //   ).cities ??
    //       [];
    //
    //   _filteredCities = cities;
    // }

    // // Reset selection if country changes (new country selected)
    // if (oldWidget.selectedCountry != widget.selectedCountry) {
    //   _selectedCity = null;
    //   _searchController.clear();
    //   widget.onCitySelected?.call(null);
    // }
    // // Update selected city if it changed from parent
    // if (oldWidget.selectedCity != widget.selectedCity) {
    //   _selectedCity = widget.selectedCity;
    // }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();

    super.dispose();
  }

  void _onSearchChanged() {
    List<String> cities = [];
    if (context.read<CountryBloc>().availableCountries != null) {
      cities = context
          .read<CountryBloc>()
          .availableCountries!
          .firstWhere(
            (element) =>
                element.country ==
                context.read<CountryBloc>().selectedCountry!.country,
          )
          .cities;
    }

    GetIt.I.get<Logger>().i(cities);
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredCities = cities;
      } else {
        setState(() {
          _filteredCities = cities
              .where(
                (city) => city.toLowerCase().contains(
                  _searchController.text.toLowerCase().trim(),
                ),
              )
              .toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: AppTextStyles.body2.copyWith(
              color: AppColors.neutralColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          8.verticalSpace,
        ],
        BlocBuilder<CountryBloc, CountryState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return _buildExpandedView(
                  context.read<CountryBloc>().selectedCountry?.cities ?? [],
                );
              },
              countrySelected: (country) {
                return _buildExpandedView(
                  context.read<CountryBloc>().selectedCountry?.cities ?? [],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildExpandedView(List<String> cities) {
    // Initialize filtered cities if not already done
    if (_filteredCities.isEmpty && cities.isNotEmpty) {
      _filteredCities = cities;
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyColor.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ExpansionTile(
        onExpansionChanged: (value) {
          if (value) {
            setState(() {
              if (context.read<CountryBloc>().availableCountries != null) {
                final cities =
                    context
                        .read<CountryBloc>()
                        .availableCountries!
                        .firstWhere(
                          (element) =>
                              element.country ==
                              context
                                  .read<CountryBloc>()
                                  .selectedCountry!
                                  .country,
                        )
                        .cities ??
                    [];

                _filteredCities = cities;
              }
            });
          }
        },
        controller: cityExpansionController,
        title: Text(
          _selectedCity != null ? _selectedCity! : 'Select city',
          style: AppTextStyles.cta2.copyWith(
            color: AppColors.greyColor,
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_down, color: AppColors.greyColor),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomTextFormField(
              height: 40,
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              hintText: 'Search cities...',
              controller: _searchController,
              suffixIcon: Icon(
                Icons.search,
                color: AppColors.greyColor,
                size: 20.sp,
              ),
              onChange: (value) {},
            ),
          ),
          10.verticalSpace,
          Container(
            constraints: BoxConstraints(maxHeight: 200.h),
            child: _filteredCities.isEmpty
                ? Container(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 32.sp,
                          color: AppColors.greyColor,
                        ),
                        8.verticalSpace,
                        Text(
                          'No cities found',
                          style: AppTextStyles.body2.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(8.w),
                    itemCount: _filteredCities.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: AppColors.greyColor.withValues(alpha: 0.2),
                    ),
                    itemBuilder: (context, index) {
                      final city = _filteredCities[index];
                      final isSelected = _selectedCity == city;

                      return ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                        title: Text(
                          city,
                          style: AppTextStyles.body3.copyWith(
                            color: AppColors.baseBlackColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        onTap: () {
                          setState(() {
                            _selectedCity = city;
                            context
                                .read<CountryBloc>()
                                .selectedCountry = context
                                .read<CountryBloc>()
                                .selectedCountry!
                                .copyWith(cities: [_selectedCity!]);
                          });
                          widget.onCitySelected?.call(city);
                          if (cityExpansionController!.isExpanded) {
                            cityExpansionController!.collapse();
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
