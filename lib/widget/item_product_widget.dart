import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/assets_image/asset_image.dart';
import '../constant/ui_color.dart';
class ItemProductWidget extends StatefulWidget {
  const ItemProductWidget({Key? key, required this.size, required this.listProduct, required this.index, required this.onPressed}) : super(key: key);
  final Size size;
  final List listProduct;
  final int index;
  final VoidCallback onPressed;
  @override
  State<ItemProductWidget> createState() => _ItemProductWidgetState();
}

class _ItemProductWidgetState extends State<ItemProductWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        height: widget.size.height / 6,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 7),
            ],
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Container(
                height:  widget.size.height / 6,
                width:  widget.size.width / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: AssetImage(widget.listProduct[widget.index]['img']),
                        fit: BoxFit.cover)),
              ),
              SizedBox(width:  widget.size.width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: UIColors.starColor,
                      ),
                      Text('${widget.listProduct[widget.index]['rating']}',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: UIColors.starColor,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                  Text(
                    '${widget.listProduct[widget.index]['title']}',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  Text(
                    '${widget.listProduct[widget.index]['text']}',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        color: UIColors.subTitleText,
                        fontSize: 14),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
                    decoration: BoxDecoration(
                      color: UIColors.loveColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Love',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: UIColors.subTitleText,
                          fontSize: 14),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );;
  }
}
