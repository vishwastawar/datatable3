import 'package:flutter/material.dart';
import 'nav_helper.dart';
import 'screens/paginated_data_table2.dart';

int offset = 10;
int limit = 10;

void main() {
  runApp(MyApp());
}

const String initialRoute = '/paginated2';

Scaffold _getScaffold(BuildContext context, Widget body,
    [List<String>? options]) {
  var defaultOption = getCurrentRouteOption(context);
  if (defaultOption.isEmpty && options != null && options.isNotEmpty) {
    defaultOption = options[0];
  }
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.grey[200],
      shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
            color: Colors.grey[850],
            //screen selection
            child: DropdownButton<String>(
              icon: const Icon(Icons.arrow_forward),
              dropdownColor: Colors.grey[800],
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.white),
              value: _getCurrentRoute(context),
              onChanged: (v) {
                Navigator.of(context).pushNamed(v!);
              },
              items: const [
                DropdownMenuItem(
                  value: '/paginated2',
                  child: Text('PaginatedDataTable2'),
                ),
              ],
            )),
        options != null && options.isNotEmpty
            ? Flexible(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 4, 0, 4),
                        child: DropdownButton<String>(
                            icon: const SizedBox(),
                            dropdownColor: Colors.grey[300],
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.black),
                            value: defaultOption,
                            onChanged: (v) {
                              var r = _getCurrentRoute(context);
                              Navigator.of(context).pushNamed(r, arguments: v);
                            },
                            items: options
                                .map<DropdownMenuItem<String>>(
                                    (v) => DropdownMenuItem<String>(
                                          value: v,
                                          child: Text(v),
                                        ))
                                .toList()))))
            : const SizedBox()
      ]),
    ),
    body: body,
  );
}

String _getCurrentRoute(BuildContext context) {
  return ModalRoute.of(context) != null &&
          ModalRoute.of(context)!.settings.name != null
      ? ModalRoute.of(context)!.settings.name!
      : initialRoute;
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'main',
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.grey[300],
      ),
      initialRoute: initialRoute,
      routes: {
        '/paginated2': (context) => _getScaffold(context,
            const PaginatedDataTable2Demo(), getOptionsForRoute('/paginated2')),
      },
    );
  }
}
