import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/screens/task_accomplished.dart';
import 'package:grocycart/services/auth/auth_controller.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';
import 'package:grocycart/widgets/const_widgets.dart';
import 'package:grocycart/widgets/spinkit_indicator.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  const AddAddressScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  final street = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final zipcode = TextEditingController();
  bool isAddressAdded = false;
  bool isScreenRefresh = false;
  bool wantToAddAddress = false;
  List<String>? addresList;

  void checkAddressAvailability() async {
    isScreenRefresh = true;
    print('CheckAvailability start');
    final isAvailable =
        await ref.read(authController).checkAddress(context: context);
    print('After checking adressAvailability => $isAvailable');
    if (isAvailable!) {
      showAddress(context);
    }
    isScreenRefresh = false;
  }

  void showAddress(BuildContext context) async {
    final addrs = await ref.watch(authController).showAddress(context: context);
    print('AddressList => $addrs');
    setState(() {
      addresList = addrs;
    });
  }

  void addingAddress() {
    final address =
        '${street.text}, ${city.text}, ${state.text}, ${country.text}, ${zipcode.text}';

    final addAddress = ref.read(authController);
    addAddress.addAddress(context: context, address: address);
    setState(() {
      isAddressAdded = true;
    });
  }

  Widget buildAddressContainer(String address) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height * 0.2,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.home,
                  size: 40,
                ),
                SizedBox(
                  width: 25,
                ),
                TextWidget(
                  content: 'Home',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
            const SizedBox(height: 8),
            TextWidget(
              content: address,
              fontSize: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    checkAddressAvailability();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TextWidget(content: 'Addresses'),
          backgroundColor: Theme.of(context).secondaryHeaderColor,
        ),
        body: isScreenRefresh
            ? spinkitProgressiveIndicator(context)
            : addresList != null
                ? Stack(
                    children: [
                      ListView.builder(
                          itemCount: addresList!.length,
                          itemBuilder: (context, index) {
                            return buildAddressContainer(addresList![index]);
                            // return ListTile(
                            //   subtitle: TextWidget(content: addresList![index]),
                            // );
                          }),
                      Visibility(
                          visible: wantToAddAddress,
                          child: Container(
                            color: Colors.white,
                            child: AddressScreen(),
                          )),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 18.0, bottom: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(25)),
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        wantToAddAddress = !wantToAddAddress;
                                      });
                                    },
                                    icon: Icon(
                                      wantToAddAddress
                                          ? Icons.cancel
                                          : Icons.add,
                                      size: 40,
                                      weight: 10,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : AddressScreen());
  }

  Widget AddressScreen() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Address',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: street,
                decoration: InputDecoration(
                  labelText: 'Street Address',
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: city,
                decoration: InputDecoration(
                  labelText: 'City',
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: state,
                decoration: InputDecoration(
                  labelText: 'State',
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: country,
                decoration: InputDecoration(
                  labelText: 'Country',
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: zipcode,
                decoration: InputDecoration(
                  labelText: 'Zip Code',
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Add address logic here
                  if (street.text.isEmpty ||
                      city.text.isEmpty ||
                      state.text.isEmpty ||
                      country.text.isEmpty ||
                      zipcode.text.isEmpty) {
                    showSnackBar(context, 'Please fill all the field');
                    // Show an error message or dialog indicating that all fields are required
                    // You can use ScaffoldMessenger.of(context).showSnackBar() or showDialog() here
                  } else if (!RegExp(r'^[0-9]+$').hasMatch(zipcode.text)) {
                    showSnackBar(context, 'Please Enter valid Zipcode');
                    // Show an error message or dialog indicating that zip code should contain only numbers
                    // You can use ScaffoldMessenger.of(context).showSnackBar() or showDialog() here
                  } else {
                    // All fields are filled, and zip code contains only numbers
                    addingAddress();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const TextWidget(
                  content: 'Add Addressses',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Visibility(
            visible: isAddressAdded,
            child:
                const TaskAccomplishedOverlay(message: 'Address successfully added')),
      ],
    );
  }
}
