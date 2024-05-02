import 'package:flutter/material.dart';
import 'package:pokeshop/models/product.dart';
import 'package:pokeshop/models/product_list.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _stockFocus = FocusNode();

  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  // ignore: unused_field, prefer_typing_uninitialized_variables
  var _dropdownValue;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['tipoItem'] = product.tipoItem;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['stock'] = product.stock;
        _formData['imgUrl'] = product.imgUrl;

        _imageUrlController.text = product.imgUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _stockFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<ProductList>(context, listen: false).saveProduct(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeShop'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildFormName(),
              _buildFormDescription(),
              _buildFormPrice(),
              _buildFormStock(),
              _buildFormDropDown(),
              _buildFormImageUrl(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormName() {
    return TextFormField(
      initialValue: _formData['name']?.toString(),
      decoration: const InputDecoration(
        labelText: 'Nome',
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_priceFocus);
      },
      onSaved: (name) => _formData['name'] = name ?? '',
      validator: (_name) {
        final name = _name ?? '';

        if (name.trim().isEmpty) {
          return 'Nome é obrigatório';
        }
        if (name.trim().length < 3) {
          return 'Nome precisa no mínimo de 3 letras.';
        }

        return null;
      },
    );
  }

  Widget _buildFormDropDown() {
    return DropdownButtonFormField(
      value: _formData.containsKey('tipoItem')
          ? _dropdownValue = _formData['tipoItem'].toString()
          : _dropdownValue = '-Selecione um tipo-',
      items: const [
        DropdownMenuItem(
          value: "-Selecione um tipo-",
          child: Text('-Selecione um tipo-'),
        ),
        DropdownMenuItem(
          value: "PokeBall",
          child: Text('PokeBall'),
        ),
        DropdownMenuItem(
          value: "Cura",
          child: Text('Cura'),
        ),
        DropdownMenuItem(
          value: "Equipamento",
          child: Text('Equipamento'),
        ),
        DropdownMenuItem(
          value: "TM",
          child: Text('TM'),
        )
      ],
      onChanged: dropdownCallback,
      onSaved: (tipoItem) => _formData['tipoItem'] = tipoItem ?? '',
      validator: (_tipoItem){
        final tipoItem = _tipoItem;
        if(tipoItem == "-Selecione um tipo-"){
          return 'Selecione um tipo';
        }
        return null;
      },
    );
  }

  Widget _buildFormPrice() {
    return TextFormField(
      initialValue: _formData['price']?.toString(),
      decoration: const InputDecoration(labelText: 'Preço'),
      focusNode: _priceFocus,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_descriptionFocus);
      },
      onSaved: (price) => _formData['price'] = double.parse(price ?? '0'),
      validator: (_price) {
        final priceString = _price ?? '0';
        final price = double.tryParse(priceString) ?? 0;

        if (price <= 0) {
          return 'Informe uma valor válido';
        }
        return null;
      },
    );
  }

  Widget _buildFormDescription() {
    return TextFormField(
      initialValue: _formData['description']?.toString(),
      decoration: const InputDecoration(labelText: 'Descrição'),
      textInputAction: TextInputAction.next,
      focusNode: _descriptionFocus,
      maxLines: 3,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_stockFocus);
      },
      onSaved: (description) => _formData['description'] = (description ?? ''),
      validator: (_description) {
        final description = _description ?? '';

        if (description.trim().isEmpty) {
          return 'Descrição é obrigatório';
        }
        if (description.trim().length < 10) {
          return 'Descrição precisa no mínimo de 10 letras.';
        }

        return null;
      },
    );
  }

  Widget _buildFormStock() {
    return TextFormField(
      initialValue: _formData['stock']?.toString(),
      decoration: const InputDecoration(labelText: 'Quantidade'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      focusNode: _stockFocus,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_imageUrlFocus);
      },
      onSaved: (stock) => _formData['stock'] = int.parse(stock ?? '0'),
      validator: (_stock) {
        final stockString = _stock ?? '';
        final stock = int.tryParse(stockString) ?? 0;

        if (stock <= 0) {
          return 'Informe uma quantidade válida';
        }
        return null;
      },
    );
  }

  Widget _buildFormImageUrl() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Url da Imagem'),
            textInputAction: TextInputAction.next,
            focusNode: _imageUrlFocus,
            keyboardType: TextInputType.url,
            controller: _imageUrlController,
            onFieldSubmitted: (_) => _submitForm(),
            onSaved: (imgUrl) => _formData['imgUrl'] = (imgUrl ?? ''),
            validator: (_imgUrl) {
              final imgUrl = _imgUrl ?? '';
              if (!isValidImageUrl(imgUrl)) {
                return 'Informe uma Url válida!';
              }
              return null;
            },
          ),
        ),
        Container(
          height: 100,
          width: 100,
          margin: const EdgeInsets.only(
            top: 10,
            left: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          child: _imageUrlController.text.isEmpty
              ? const Text('Informe a Url')
              : Image.network(_imageUrlController.text),
        ),
      ],
    );
  }
}
