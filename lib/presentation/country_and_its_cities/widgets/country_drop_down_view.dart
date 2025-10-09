
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../../core/common_widgets/custom_text_form_field.dart';
import '../../../core/common_widgets/shape_shimmer_loading.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../bloc/country_bloc.dart';
import '../data/models/country_and_its_cities.dart';

class CountryDropdownView extends StatefulWidget {
  final String? title;
  final String hintText;
  final CountryAndItsCities? selectedCountry;
  final Function(CountryAndItsCities?)? onCountrySelected;
  final String? Function(CountryAndItsCities?)? validator;

  const CountryDropdownView({
    super.key,
    this.title,
    required this.hintText,
    this.selectedCountry,
    this.onCountrySelected,
    this.validator,
  });

  @override
  State<CountryDropdownView> createState() => _CountryDropdownViewState();
}

class _CountryDropdownViewState extends State<CountryDropdownView> {
  CountryAndItsCities? _selectedCountry;
  final TextEditingController _searchController = TextEditingController();
  List<CountryAndItsCities> _filteredCountries = [];
  ExpansibleController? expansionController=ExpansibleController();
  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.selectedCountry;
    _searchController.addListener(_onSearchChanged);
    context.read<CountryBloc>().add(const CountryEvent.fetchCountries());
  }

  @override
  void didUpdateWidget(CountryDropdownView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update selected country if it changed from parent
    if (oldWidget.selectedCountry != widget.selectedCountry) {
      _selectedCountry = widget.selectedCountry;
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    expansionController?.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final countries = context.read<CountryBloc>().availableCountries ?? [];
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredCountries = countries;
      } else {

        setState(() {
          _filteredCountries = countries
              .where((country) => country.country.toLowerCase().contains(_searchController.text.toLowerCase().trim()))
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
        BlocConsumer<CountryBloc, CountryState>(
          buildWhen: (previous, current) {
            return current.maybeWhen(orElse: () => false,loading: () => true,countriesLoaded: (cities) => true,error: (message) => true,);
          },
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => {},
              initial: () {},
              loading: () {},
              countriesLoaded: (countries) {},
              error: (message) {
                SnackbarUtils.showCustomToast(context, message, isError: true);
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => SizedBox(),
              initial: () => _buildExpandedView(context, []),
              loading: () => _buildLoadingField(),
              countriesLoaded: (countries) => _buildExpandedView(context, countries),
              error: (message) => _buildExpandedView(context, []),
            );
          },
        ),
      ],
    );
  }

  Widget _buildExpandedView(BuildContext context, List<CountryAndItsCities> countries) {
    // Initialize filtered countries if not already done
    if (_filteredCountries.isEmpty && countries.isNotEmpty) {
      _filteredCountries = countries;
    }


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.greyColor.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: ExpansionTile(
            controller: expansionController,
            title: Text(
              _selectedCountry != null
                  ? _selectedCountry!.country
                  : widget.hintText,
              style: AppTextStyles.cta2.copyWith(

                color: AppColors.greyColor,

              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.greyColor,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomTextFormField(
                  height: 40,
                  contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  hintText: 'Search countries...',
                  controller: _searchController,
                  suffixIcon: Icon(
                    Icons.search,
                    color: AppColors.greyColor,
                    size: 20.sp,
                  ),
                  onChange: (value) {
                  },
                ),
              ),

              Container(
                constraints: BoxConstraints(
                  maxHeight: 200.h,
                ),
                child: _filteredCountries.isEmpty
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
                              'No countries found',
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
                        itemCount: _filteredCountries.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: AppColors.greyColor.withValues(alpha: 0.2),
                        ),
                        itemBuilder: (context, index) {
                          final country = _filteredCountries[index];
                          final isSelected = _selectedCountry == country;
                          
                          return ListTile(
                            visualDensity: VisualDensity(vertical: -4),
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                            ),
                            title: Text(
                              country.country,
                              style: AppTextStyles.body3.copyWith(
                                color:  AppColors.baseBlackColor,
                                fontWeight: FontWeight.w400

                              ),
                            ),

                            onTap: () {
                              setState(() {
                                _selectedCountry = country;
                              });
                              widget.onCountrySelected?.call(country);
                              if(expansionController!.isExpanded){
                                expansionController!.collapse();
                              }
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingField() {
    return ShapeShimmerLoading(
      width: double.infinity,
      height: 57.h,
    );
  }
}