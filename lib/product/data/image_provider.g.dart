// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productImagesHash() => r'20df24a44817f5ede3fc6cbd8852812d12b226b6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [productImages].
@ProviderFor(productImages)
const productImagesProvider = ProductImagesFamily();

/// See also [productImages].
class ProductImagesFamily extends Family<AsyncValue<List<String>>> {
  /// See also [productImages].
  const ProductImagesFamily();

  /// See also [productImages].
  ProductImagesProvider call(
    String productKey,
  ) {
    return ProductImagesProvider(
      productKey,
    );
  }

  @override
  ProductImagesProvider getProviderOverride(
    covariant ProductImagesProvider provider,
  ) {
    return call(
      provider.productKey,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productImagesProvider';
}

/// See also [productImages].
class ProductImagesProvider extends AutoDisposeFutureProvider<List<String>> {
  /// See also [productImages].
  ProductImagesProvider(
    String productKey,
  ) : this._internal(
          (ref) => productImages(
            ref as ProductImagesRef,
            productKey,
          ),
          from: productImagesProvider,
          name: r'productImagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productImagesHash,
          dependencies: ProductImagesFamily._dependencies,
          allTransitiveDependencies:
              ProductImagesFamily._allTransitiveDependencies,
          productKey: productKey,
        );

  ProductImagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productKey,
  }) : super.internal();

  final String productKey;

  @override
  Override overrideWith(
    FutureOr<List<String>> Function(ProductImagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductImagesProvider._internal(
        (ref) => create(ref as ProductImagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productKey: productKey,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _ProductImagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductImagesProvider && other.productKey == productKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProductImagesRef on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `productKey` of this provider.
  String get productKey;
}

class _ProductImagesProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with ProductImagesRef {
  _ProductImagesProviderElement(super.provider);

  @override
  String get productKey => (origin as ProductImagesProvider).productKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
