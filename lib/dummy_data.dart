import '../features/shop/models/banner_model.dart';
import '../features/shop/models/brand_model.dart';
import '../features/shop/models/category_model.dart';
import '../features/shop/models/product_attribute_model.dart';
import '../features/shop/models/product_model.dart';
import '../features/shop/models/product_variation_model.dart';
import '../routes/routes.dart';
import '../utils/constants/image_strings.dart';
import 'features/shop/models/brand_category_model.dart';
import 'features/shop/models/product_category_model.dart';

class CDummyData {
  /// List of all Banners
  static final List<BannerModel> banner = [
    BannerModel(
      imageUrl: CImages.promoBanner1,
      targetScreen: CRoutes.home,
      active: true,
    ),
    BannerModel(
      imageUrl: CImages.promoBanner2,
      targetScreen: CRoutes.wishlist,
      active: true,
    ),
    BannerModel(
      imageUrl: CImages.promoBanner3,
      targetScreen: CRoutes.settings,
      active: true,
    ),
    BannerModel(imageUrl: CImages.banner1, targetScreen: '', active: true),
    BannerModel(
      imageUrl: CImages.banner2,
      targetScreen: CRoutes.settings,
      active: true,
    ),
    BannerModel(
      imageUrl: CImages.banner3,
      targetScreen: CRoutes.userProfile,
      active: false,
    ),
  ];

  /// List of all Categories
  static final List<CategoryModel> categories = [
    /// Parent Categories
    CategoryModel(
      id: '01',
      name: 'Clothes',
      image: CImages.clothIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '02',
      name: 'Shoes',
      image: CImages.shoeIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '03',
      name: 'Cosmetics',
      image: CImages.cosmeticsIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '04',
      name: 'Jeweleries',
      image: CImages.jeweleryIcon,
      isFeatured: true,
    ),

    /// Clothes
    CategoryModel(
      id: '05',
      name: 'Shirts',
      image: CImages.shirtIcon,
      parentId: '01',
    ),
    CategoryModel(
      id: '06',
      name: 'Jackets',
      image: CImages.jacketIcon,
      parentId: '01',
    ),
    CategoryModel(
      id: '07',
      name: 'Shorts',
      image: CImages.shortsIcon,
      parentId: '01',
    ),

    /// Shoes
    CategoryModel(
      id: '08',
      name: 'Formal Shoes',
      image: CImages.formalShoeIcon,
      parentId: '02',
    ),
    CategoryModel(
      id: '09',
      name: 'Sports Shoes',
      image: CImages.sportsShoeIcon,
      parentId: '02',
    ),

    /// Cosmetics
    CategoryModel(
      id: '10',
      name: 'Perfumes',
      image: CImages.perfumeIcon,
      parentId: '03',
    ),

    /// Jeweleries
    CategoryModel(
      id: '11',
      name: 'Bags',
      image: CImages.bagIcon,
      parentId: '04',
    ),
    CategoryModel(
      id: '12',
      name: 'Watches',
      image: CImages.watchIcon,
      parentId: '04',
    ),
  ];

  /// List of all Brands
  static final List<BrandModel> brands = [
    BrandModel(
      id: '1',
      image: CImages.nikeLogo,
      name: 'Nike',
      productsCount: 1,
      isFeatured: true,
    ),
    BrandModel(
      id: '2',
      image: CImages.breakoutLogo,
      name: 'Breakout',
      productsCount: 2,
      isFeatured: true,
    ),
    BrandModel(
      id: '3',
      image: CImages.jLogo,
      name: 'J.',
      productsCount: 2,
      isFeatured: true,
    ),
    BrandModel(
      id: '4',
      image: CImages.ndureLogo,
      name: 'NDURE',
      productsCount: 1,
      isFeatured: true,
    ),
    BrandModel(
      id: '5',
      image: CImages.northStarLogo,
      name: 'NorthStar',
      productsCount: 1,
      isFeatured: true,
    ),
    BrandModel(
      id: '6',
      image: CImages.poloLogo,
      name: 'Polo',
      productsCount: 1,
      isFeatured: true,
    ),
  ];

  /// List of all products - 8 Products
  static final List<ProductModel> products = [
    // Nike - Brand[0] - Category 09 sports shoes
    // 001
    ProductModel(
      id: '001',
      title: 'Green Nike Sports Shoe',
      thumbnail: CImages.productImage4,
      images: [
        CImages.productImage4a,
        CImages.productImage4b,
        CImages.productImage4c,
      ],
      isFeatured: true,
      stock: 21,
      price: 39.99,
      date: DateTime(2024, 1, 15),
      productType: 'ProductType.variable',
      categoryId: '09',
      brand: brands[0],
      sku: "NIKE-SPORTS-SHOES",
      searchKeywords: ['nike', 'shoe', 'sports', 'green', 'shoes'],
      description:
          "Step into effortless fashion with Green Nike Sports Shoe. These casual yet stylish shoes are perfect for pairing with jeans, skirts, or athleisure wear—ideal for everything from brunch to weekend strolls.",
      productAttributes: [
        ProductAttributeModel(
          name: 'Color',
          values: ['Red', 'Blue', 'Cyan', 'Black'],
        ),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          attributeValues: {'Color': 'Red'},
          stock: 21,
          description: 'This is description of Red',
          sku: 'NIKE-SPORTS-SHOES',
          price: 39.99,
          image: CImages.productImage4,
        ),
        ProductVariationModel(
          id: '2',
          attributeValues: {'Color': 'Blue'},
          stock: 20,
          description: 'This is description of Blue',
          sku: 'NIKE-SPORTS-SHOES',
          price: 89.99,
          salePrice: 84.99,
          image: CImages.productImage4a,
        ),
        ProductVariationModel(
          id: '3',
          attributeValues: {'Color': 'Cyan'},
          stock: 0,
          description: 'This is description of Cyan',
          sku: 'NIKE-SPORTS-SHOES',
          price: 79.99,
          salePrice: 64.99,
          image: CImages.productImage4b,
        ),
        ProductVariationModel(
          id: '4',
          attributeValues: {'Color': 'Black'},
          stock: 2,
          description: 'This is description of Black',
          sku: 'NIKE-SPORTS-SHOES',
          price: 129.99,
          salePrice: 104.99,
          image: CImages.productImage4c,
        ),
      ],
    ),

    // Breakout[2] - Brand[1] - Category 05 shirt
    // 002
    ProductModel(
      id: '002',
      title: 'Breakout Men’s Relaxed Fit Shirt - Light Grey (Short Sleeve)',
      price: 29.99,
      salePrice: 23.99,
      thumbnail: CImages.productImage18,
      stock: 12,
      date: DateTime(2024, 3, 20),
      brand: brands[1],
      categoryId: '05',
      description:
          "Keep it cool and casual with this light grey relaxed fit shirt from Breakout. Featuring short sleeves, a soft collar, and breathable fabric, it’s perfect for summer days, beach outings, or layering over a tee. A wardrobe staple with effortless style.",
      sku: "SHORT-WHITE-BREAKOUT",
      searchKeywords: ['breakout', 'shirt', 'men', 'grey', 'relaxed'],
      productType: 'ProductType.single',
    ),

    // Breakout - Brand[1] - Category 06 jacket
    // 003
    ProductModel(
      id: '003',
      title: '“S” Varsity Bomber Jacket - Red & White Edition',
      thumbnail: CImages.productImage49a,
      images: [CImages.productImage49b],
      isFeatured: true,
      stock: 21,
      price: 89.99,
      salePrice: 84.99,
      date: DateTime(2024, 2, 10),
      productType: 'ProductType.variable',
      categoryId: '06',
      brand: brands[1],
      sku: "BREAKOUT-JACKET-RED",
      searchKeywords: ['breakout', 'jacket', 'bomber', 'varsity', 'red', 's'],
      description:
          "Make a statement with this retro-inspired Varsity Bomber Jacket, featuring a bold red body, contrasting white leather-look sleeves, and a stitched S emblem on the chest. Whether you’re channeling school spirit or street-style cool, this jacket brings timeless edge and warmth in one fresh fit.",
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Blue', 'Red']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          attributeValues: {'Color': 'Blue'},
          stock: 23,
          description: 'This is description of Blue',
          sku: 'SKU-BREAKOUT',
          price: 89.99,
          salePrice: 84.99,
          image: CImages.productImage49a,
        ),
        ProductVariationModel(
          id: '2',
          attributeValues: {'Color': 'Red'},
          stock: 23,
          description: 'This is description of Red',
          sku: 'SKU-BREAKOUT',
          price: 89.99,
          salePrice: 84.99,
          image: CImages.productImage49b,
        ),
      ],
    ),

    // J.[2] - Brand[2] - Category 11 perfume
    // 004
    ProductModel(
      id: '004',
      title: 'Smoky Vanillin - Romantic Perfume 150ml',
      stock: 10,
      price: 70,
      isFeatured: true,
      thumbnail: CImages.productImage7,
      description:
          "Smoky Vanillin is an intense and captivating fragrance that blends rich vanilla with deep smoky undertones. Designed for those who love bold and lasting scents, this perfume brings a touch of luxury and mystery to your signature style.",
      brand: brands[2],
      salePrice: 64.99,
      date: DateTime(2024, 5, 5),
      sku: 'SKU-PERFUME',
      searchKeywords: ['j.', 'perfume', 'smoky', 'vanillin', 'romantic'],
      categoryId: '11',
      productType: 'ProductType.single',
    ),

    // J. - Brand[2] - Category 10 bag
    // 005
    ProductModel(
      id: '005',
      title: 'Elegant Tassel Handbag - Berry Pink',
      thumbnail: CImages.productImage24,
      price: 59.99,
      salePrice: 48.99,
      stock: 43,
      brand: brands[2],
      date: DateTime(2024, 7, 1),
      description:
          "This berry pink handbag combines elegance with everyday functionality. Featuring dual top handles, a structured silhouette, and a statement gold-accented tassel, it’s perfect for elevating your outfit — whether at work, brunch, or a night out.",
      sku: 'J.-BAG',
      searchKeywords: [
        'j.',
        'bag',
        'handbag',
        'elegant',
        'tassel',
        'pink',
        'female',
      ],
      categoryId: '10',
      productType: 'ProductType.single',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['White', 'Red']),
      ],
    ),

    // NDURE[1] - Brand[3] - Category 08 formal shoes
    // 006
    ProductModel(
      id: '006',
      title: 'Men’s Classic Slip-On Dress Shoes - Tan Brown',
      price: 59.99,
      salePrice: 49.99,
      thumbnail: CImages.productImage19a,
      images: [CImages.productImage19b],
      stock: 12,
      date: DateTime(2024, 4, 18),
      brand: brands[3],
      categoryId: '08',
      description:
          "Add timeless charm to your formal look with these sleek tan brown slip-on dress shoes. Featuring a smooth leather finish, cushioned insole, and durable sole, they’re perfect for the office, business events, or formal occasions.",
      sku: "FORMAL-BROWN-NDURE",
      searchKeywords: [
        'ndure',
        'men',
        'classic',
        'slip-on',
        'dress',
        'shoes',
        'formal',
        'brown',
      ],
      productType: 'ProductType.single',
    ),

    // NorthStar - Brand[4] - Category 10 bag
    // 007
    ProductModel(
      id: '007',
      title: 'North Star Classic Backpack - Red & Black Edition',
      thumbnail: CImages.productImage45a,
      images: [CImages.productImage45b],
      isFeatured: true,
      stock: 21,
      price: 29.99,
      salePrice: 28.99,
      date: DateTime(2024, 6, 25),
      productType: 'ProductType.variable',
      categoryId: '10',
      brand: brands[4],
      sku: "NORTHSTAR_BAG",
      description:
          "Step out in style with the North Star Classic Backpack, featuring a striking red-and-black design and practical layout for everyday use. Whether you’re heading to school, work, or a weekend trip, this durable backpack keeps your essentials organized and secure.",
      searchKeywords: [
        'north',
        'star',
        'classic',
        'backpack',
        'red',
        'black',
        'bag',
      ],
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Red', 'Green']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          attributeValues: {'Color': 'Red'},
          stock: 23,
          description: 'This is description of Red',
          sku: 'SKU-NORTHSTAR',
          price: 29.99,
          salePrice: 28.99,
          image: CImages.productImage45a,
        ),
        ProductVariationModel(
          id: '2',
          attributeValues: {'Color': 'Green'},
          stock: 23,
          description: 'This is description of Green',
          sku: 'SKU-NORTHSTAR',
          price: 29.99,
          salePrice: 28.99,
          image: CImages.productImage45b,
        ),
      ],
    ),

    // POLO [1] - Brand[5] - Category 05 Shirt
    // 008
    ProductModel(
      id: '008',
      title: 'AquaCore Classic Polo',
      thumbnail: CImages.productImage67a,
      images: [CImages.productImage67b, CImages.productImage67c],
      isFeatured: true,
      date: DateTime(2024, 3, 30),
      stock: 2,
      price: 8,
      productType: 'ProductType.variable',
      categoryId: '05',
      brand: brands[5],
      sku: "POLO-SHIRT",
      searchKeywords: [
        'polo',
        'shirt',
        'aquacore',
        'classic',
        'aqua',
        'blue',
        'green',
      ],
      description:
          "Add a splash of freshness to your wardrobe with the AquaCore Classic Polo. Made from breathable cotton, it features a sleek collar, button placket, and a perfect slim fit for all-day comfort. Ideal for both casual outings and semi-formal looks.",
      productAttributes: [
        ProductAttributeModel(
          name: 'Color',
          values: ['Blue', 'Dark Blue', 'Green'],
        ),
        ProductAttributeModel(name: 'Size', values: ['Medium', 'Large']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          attributeValues: {'Color': 'Blue', 'Size': 'Medium'},
          stock: 23,
          description: 'This is description of Blue',
          sku: 'SKU-BREAKOUT',
          price: 8,
          image: CImages.productImage67a,
        ),
        ProductVariationModel(
          id: '2',
          attributeValues: {'Color': 'Blue', 'Size': 'Large'},
          stock: 23,
          description: 'This is description of Blue',
          sku: 'SKU-BREAKOUT',
          price: 8,
          image: CImages.productImage67b,
        ),
        ProductVariationModel(
          id: '3',
          attributeValues: {'Color': 'Dark Blue', 'Size': 'Medium'},
          stock: 23,
          description: 'This is description of Blue',
          sku: 'SKU-BREAKOUT',
          price: 8,
          image: CImages.productImage67c,
        ),
        ProductVariationModel(
          id: '4',
          attributeValues: {'Color': 'Dark Blue', 'Size': 'Large'},
          stock: 23,
          description: 'This is description of Blue',
          sku: 'SKU-BREAKOUT',
          price: 8,
          image: CImages.productImage67a,
        ),
        ProductVariationModel(
          id: '5',
          attributeValues: {'Color': 'Green', 'Size': 'Medium'},
          stock: 23,
          description: 'This is description of Blue',
          sku: 'SKU-BREAKOUT',
          price: 8,
          image: CImages.productImage67b,
        ),
        ProductVariationModel(
          id: '6',
          attributeValues: {'Color': 'Green', 'Size': 'Large'},
          stock: 23,
          description: 'This is description of Blue',
          sku: 'SKU-BREAKOUT',
          price: 8,
          image: CImages.productImage67a,
        ),
      ],
    ),
  ];

  static final List<BrandCategoryModel> brandCategory = [
    BrandCategoryModel(categoryId: '01', brandId: '2'), // Clothes - Breakout
    BrandCategoryModel(categoryId: '01', brandId: '6'), // Clothes - Polo
    BrandCategoryModel(categoryId: '02', brandId: '1'), // Shoes - Nike
    BrandCategoryModel(categoryId: '02', brandId: '4'), // Shoes - NDURE
    BrandCategoryModel(categoryId: '03', brandId: '3'), // Cosmetics - j.
    BrandCategoryModel(
      categoryId: '04',
      brandId: '5',
    ), // Jeweleries - North Star
    BrandCategoryModel(categoryId: '04', brandId: '3'), // Jeweleries - j.
  ];

  static final List<ProductCategoryModel> productCategory = [
    // Clothes Category
    ProductCategoryModel(
      categoryId: '01',
      productId: '002',
    ), // -- Breakout (Shirt)
    ProductCategoryModel(
      categoryId: '01',
      productId: '003',
    ), //-- Breakout (Jacket)
    ProductCategoryModel(categoryId: '01', productId: '008'), //-- Polo (Shirt)
    // Shoes Category
    ProductCategoryModel(
      categoryId: '02',
      productId: '001',
    ), //-- Nike (Variable)
    ProductCategoryModel(categoryId: '02', productId: '006'), //-- Ndure
    // Cosmetics Category
    ProductCategoryModel(categoryId: '03', productId: '004'), // -- J.
    // Jeweleries Category
    ProductCategoryModel(categoryId: '04', productId: '005'), //-- J.
    ProductCategoryModel(categoryId: '04', productId: '007'), // -- NorthStar
    // Shirts
    ProductCategoryModel(
      categoryId: '05',
      productId: '002',
    ), //-- Breakout (Shirt)
    ProductCategoryModel(categoryId: '05', productId: '008'), // -- Polo (Shirt)
    // Jackets
    ProductCategoryModel(
      categoryId: '06',
      productId: '003',
    ), //-- Breakout (Jacket)
    // Shorts

    // Formal Shoes
    ProductCategoryModel(categoryId: '08', productId: '006'), //-- Ndure
    // Sports Shoes
    ProductCategoryModel(
      categoryId: '09',
      productId: '001',
    ), //-- Nike (Variable)
    // Perfumes
    ProductCategoryModel(categoryId: '10', productId: '004'), //-- J.
    // Bags
    ProductCategoryModel(categoryId: '11', productId: '005'), //-- J.
    ProductCategoryModel(categoryId: '11', productId: '007'), //-- NorthStar
    // Watches
  ];
}
