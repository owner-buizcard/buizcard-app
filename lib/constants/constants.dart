import '../models/integration.dart';

class Constants {

  static List qrEyeStyle = [
      {
          'label': "Square",
          'value': "square"
      },
      {
          'label': "Circle",
          'value': "circle"
      }
  ];

  static List qrCodeStyle = [
    {
        'label': "Dot",
        'value': "dots"
    },
    {
        'label': "Square",
        'value': "squares"
    }
  ];

  static List pickerColors = [
      "#3498db", // Blue
      "#e74c3c", // Red
      "#2ecc71", // Green
      "#f39c12", // Orange
      "#9b59b6", // Purple
      "#e67e22", // Pumpkin
      "#f1c40f", // Yellow
  ];

  static List<Integration> defaultExports = [
    const Integration(id: 'csv', name: 'CSV', authLink: '', image: 'https://firebasestorage.googleapis.com/v0/b/bizcard-spiderlingz.appspot.com/o/app_icons%2Fexcel.png?alt=media&token=a54a4f0e-7431-4294-bb62-9274a528ef7e', description: '', group: 'CRM', authType: ''),
    const Integration(id: 'excel', name: 'Excel', authLink: '', image: 'https://firebasestorage.googleapis.com/v0/b/bizcard-spiderlingz.appspot.com/o/app_icons%2Fcsv.png?alt=media&token=9d342e95-aa6b-488a-b699-7fd19d248720', description: '', group: 'CRM', authType: '')
  ];

}