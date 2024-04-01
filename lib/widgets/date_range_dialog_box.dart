import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/widgets/text_widget.dart';

class DateRangeDialog extends StatefulWidget {
  final Function(String)? startDate;
  final Function(String)? endDate;
  final Function(String)? password;
  const DateRangeDialog({Key? key, this.startDate, this.endDate, this.password}) : super(key: key);

  @override
  _DateRangeDialogState createState() => _DateRangeDialogState();
}

class _DateRangeDialogState extends State<DateRangeDialog> {
  late DateTime _startDate;
  late DateTime _endDate;
  late TextEditingController _textFieldController;

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now().subtract(Duration(days: 90));
    _endDate = DateTime.now();
    _textFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context, initialDate: _startDate, firstDate: DateTime(2000), lastDate: DateTime.now());
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context, initialDate: _endDate, firstDate: DateTime(2000), lastDate: DateTime.now());
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      title: MyText(
        fontSize: 20.sp,
        text: 'Select Date Range',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 250.h,
        width: 300.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const MyText(text: 'Start Date:'),
                GestureDetector(
                  onTap: () => _selectStartDate(context),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyText(
                        text: '${_startDate.day}/${_startDate.month}/${_startDate.year}',
                        color: MyColor.purpleColor,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(width: 15.w),
                      Icon(
                        Icons.calendar_month,
                        color: MyColor.purpleColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () => _selectEndDate(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MyText(text: 'End Date:'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyText(
                        text: '${_endDate.day}/${_endDate.month}/${_endDate.year}',
                        color: MyColor.purpleColor,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(width: 15.w),
                      Icon(
                        Icons.calendar_month,
                        color: MyColor.purpleColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _textFieldController,
              decoration:
                  InputDecoration(hintText: 'Enter password here (Optional)', hintStyle: TextStyle(fontSize: 14.sp)),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.startDate!(_startDate.toString().substring(0, 10));
            widget.endDate!(_endDate.toString().substring(0, 10));
            widget.password!(_textFieldController.text.trim().toString());
            Navigator.of(context).pop();
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
