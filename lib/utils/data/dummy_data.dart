import 'package:ecommerce/features/shop/models/banner_model.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';

class TDummyData {
  // BANNER
  static final List<BannerModel> banners = [
    BannerModel(imageUrl: TImages.banner1, targetScreen: TRoutes.order, active: false),
    BannerModel(imageUrl: TImages.banner2, targetScreen: TRoutes.cart, active: true),
    BannerModel(imageUrl: TImages.banner3, targetScreen: TRoutes.favourites, active: true),
    BannerModel(imageUrl: TImages.banner4, targetScreen: TRoutes.search, active: true),
    BannerModel(imageUrl: TImages.banner5, targetScreen: TRoutes.settings, active: true),
    BannerModel(imageUrl: TImages.banner6, targetScreen: TRoutes.userAddress, active: true),
    BannerModel(imageUrl: TImages.banner8, targetScreen: TRoutes.checkout, active: true),
  ];

  // LIST CATEGORIES
  static final List<CategoryModel> categories = [
    CategoryModel(id: '1', name: 'Sports', image: TImages.sportIcon, isFeatured: true),
    CategoryModel(id: '2', name: 'Furniture', image: TImages.furnitureIcon, isFeatured: true),
    CategoryModel(id: '3', name: 'Electronics', image: TImages.electronicsIcon, isFeatured: true),
    CategoryModel(id: '4', name: 'Clothes', image: TImages.clothIcon, isFeatured: true),
    CategoryModel(id: '5', name: 'Animals', image: TImages.animalIcon, isFeatured: true),
    CategoryModel(id: '6', name: 'Shoes', image: TImages.shoeIcon, isFeatured: true),
    CategoryModel(id: '7', name: 'Cosmetic', image: TImages.cosmeticsIcon, isFeatured: true),
    CategoryModel(id: '14', name: 'Jewelery', image: TImages.jeweleryIcon, isFeatured: true),

    // SUB CATEGORIES
    CategoryModel(id: '8', name: 'Sports Shoes', image: TImages.sportIcon, isFeatured: false, parentId: '1'),
    CategoryModel(id: '9', name: 'Track suits', image: TImages.sportIcon, isFeatured: false, parentId: '1'),
    CategoryModel(id: '10', name: 'Sports Equipments', image: TImages.sportIcon, isFeatured: false, parentId: '1'),

    // FURNITURE
    CategoryModel(id: '11', name: 'Bedrrom Furniture', image: TImages.furnitureIcon, isFeatured: false, parentId: '2'),
    CategoryModel(id: '12', name: 'Kitchen Furniture', image: TImages.furnitureIcon, isFeatured: false, parentId: '2'),
    CategoryModel(id: '13', name: 'Office Furniture', image: TImages.furnitureIcon, isFeatured: false, parentId: '2'),

    // ELECTRONICS
    CategoryModel(id: '15', name: 'Laptop', image: TImages.electronicsIcon, isFeatured: false, parentId: '3'),
    CategoryModel(id: '16', name: 'Mobile', image: TImages.electronicsIcon, isFeatured: false, parentId: '3'),
  ];
}
