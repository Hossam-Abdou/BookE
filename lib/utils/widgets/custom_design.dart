import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDesign extends StatelessWidget {
String? image;
String? name;
String? category;
String? description;
String? price;
String? priceAfter;
final VoidCallback? onPressed;
final VoidCallback? SecondOnPressed;
 Widget icon;

CustomDesign(
    {this.image,
      this.name,
      this.category,
      this.description,
      this.price,
      this.priceAfter,
      required this.icon,
      this.onPressed,
      this.SecondOnPressed

    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueGrey)
      ),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network('$image',height: 125.h,width:105.w,errorBuilder: (context, error, stackTrace) => Image.network('https://img.freepik.com/free-vector/books-stack-realistic_1284-4735.jpg'),)),
          SizedBox(width: 10.w,),
          SizedBox(
            height: 125.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width:150.w,
                    child: Text('$name',overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.roboto(fontWeight: FontWeight.bold),)),
                Spacer(),
                Text('$price L.E',style: GoogleFonts.roboto(decoration: TextDecoration.lineThrough,color: Colors.red[300],fontSize: 13,)),
                Text('$priceAfter L.E',style: GoogleFonts.roboto(fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Spacer(),
          SizedBox(height: 125.h,
            child: Column(
              children: [
                IconButton(onPressed: onPressed,
                  // cubit.addToFav(id: cubit.booksModel?.data?.products?[index].id ?? 0);

                  icon: icon),
                Spacer(),
                IconButton(onPressed: SecondOnPressed,

                  // cubit.addToCart(id: cubit.booksModel?.data?.products?[index].id ?? 0);

                  icon: Icon(Icons.add_shopping_cart_rounded,color: Colors.blueGrey,),),


              ],
            ),
          ),

        ],
      ),
    );
  }
}
