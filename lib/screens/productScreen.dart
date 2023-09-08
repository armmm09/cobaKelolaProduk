import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../data/models/data_models.dart';
import '../widget/product_notifier.dart';


    

class ProductListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productku = ref.read(productProvider.notifier);
    
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Product'),
        actions: [
          const Icon(Ti.plus).onPressed(() {
            context.push(FormProduct(notifier: productku));
          }),
        ],
      ),
      body: productku.watch((state) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LzTextField(
                hint: 'Search.......',
                onChange: (query) {
                  state.search(query);
                },
              ),
            ),
            Expanded(
              child: Refreshtor(
                onRefresh: () async {
                  await state.getProduct();
                },
                child: LzListView(
                  children: state.searchResults.isNotEmpty
                      ? state.searchResults.generate((item, i) {
                          return ListTile(
                            title: Text(item.namaProduk ?? ''),
                            subtitle: Text(
                                'Harga: ${item.harga}, Stock: ${item.stock}'),
                            leading: Image.network(item.gambar ?? ''),
                          ); // untuk melakukan searach
                        })
                      : productku.products.generate((item, i) {
                          final key = GlobalKey();
                          return ListTile(
                            title: Text(item.namaProduk ?? ''),
                            subtitle: Text(
                                'Harga: ${item.harga}, Stock: ${item.stock}'),
                            leading: Image.network(item.gambar ?? ''),
                            key: key,
                            onTap: () {
                              DropX.show(key,
                                  options: ['Edit', 'Delete'].options(
                                      icons: [Ti.pencil, Ti.trash],
                                      dangers: [1]), onSelect: (value) {
                                if (value.option == 'Edit') {
                                  context.push(FormProduct(
                                    notifier: productku,
                                    data: item,
                                  ));
                                } else {
                                  LzConfirm(
                                      title: 'Hapus data',
                                      type: LzConfirmType.bottomSheet,
                                      message:
                                          'Anda yakin ingin menghapus data ini?',
                                      onConfirm: () => productku.deleteProduct(
                                          item.id!)).show(context);
                                }
                              });
                            },
                              trailing: Icon(Ti.dotsVertical),
                          );
                          
                        },
                        ),
                ),
              ),
            ),
          ],
        )
      )
        );
      
  }
}

class FormProduct extends StatelessWidget {
  final ProductListNotifier notifier;
  final Product? data;

  const FormProduct({Key? key, required this.notifier, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forms = LzForm.make(['namaProduk', 'harga', 'stock', 'gambar']);

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(data == null ? 'Tambah Produk' : 'Edit Produk'),
      ),
     body: LzFormList(
        padding:  Ei.all(20),
        children: [
          LzForm.input(
            label: 'Nama Produk',
            hint: '...............',
            model: forms['namaProduk'],
            autofocus: true,
          ),
          LzForm.input(
            label: 'Harga',
            hint: '...........',
            model: forms['harga'],
            keyboard: TextInputType.numberWithOptions()
          ),
          LzForm.input(
            label: 'Stock',
            hint: '.........',
            model: forms['stock'],
            keyboard: TextInputType.numberWithOptions()
          ),
          LzForm.input(
            label: 'Url',
            hint: '..........',
            model: forms['gambar'],
            
          ),
        ],
      ),
      bottomNavigationBar: LzButton(
            text: 'Submit',
            onTap: (state) {
              // validasi form
              final form = LzForm.validate(forms,
                  required: ['*'],
                  messages:
                      FormMessages(required: {'title': 'Title harus diisi'}));

              if (form.ok) {
                // jika data tidak null, maka update
                if (data != null) {
                  notifier.update(data!.id!,
                      Product.fromJson({'id': data!.id, ...form.value}));
                  context.pop();
                  return;
                }

                // generate random id
                int id = DateTime.now().millisecondsSinceEpoch;
                final payload = {
                  'id': id,
                  ...form.value
                }; // payload itu sebutan untuk data yang akan dikirim ke server
                notifier.create(Product.fromJson(payload));
                context.pop();
              }
            }).theme1(),
      );
    
  }
}
    