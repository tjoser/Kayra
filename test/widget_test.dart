void _showPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("ÜRÜN SİPARİŞ ÇIKIŞI"),
        backgroundColor: Color(0xFFFEECDE),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Enter the parcode',
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              // Add your code here for the "Tamam" button action
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Tamam"),
          ),
        ],
      );
    },
  );
}
