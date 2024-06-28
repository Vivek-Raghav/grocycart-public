import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

Widget cardSwiper(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return SizedBox(
    height: size.height * 0.25,
    width: double.infinity,
    child: Swiper(
      pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
              color: Colors.white, activeColor: Colors.green)),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) => Image.network(
        'https://img.freepik.com/free-vector/gradient-supermarket-facebook-cover-template_23-2149381861.jpg?w=1800&t=st=1706607508~exp=1706608108~hmac=fde9a6b8c3f404026ee3338e0957bc325225a6f5925b05743715d3bce197ec99',
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget onSale() {
  return const Center(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 15,
          backgroundImage: NetworkImage(
            'https://cdn-icons-png.freepik.com/256/726/726476.png?uid=R73264043&ga=GA1.1.1412754649.1700567433&semt=ais',
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'ON SALE',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        SizedBox(
          width: 10,
        ),
        CircleAvatar(
          radius: 15,
          backgroundImage: NetworkImage(
            'https://cdn-icons-png.freepik.com/256/726/726476.png?uid=R73264043&ga=GA1.1.1412754649.1700567433&semt=ais',
          ),
        ),
      ],
    ),
  );
}
