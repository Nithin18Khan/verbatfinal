import 'package:verbat_iot_final/model/extension/config.dart';

class SearchResultsTable extends StatelessWidget {
  const SearchResultsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('#')),
        DataColumn(label: Text('National ID')),
        DataColumn(label: Text('Farm ID')),
        DataColumn(label: Text('Farmer Name')),
        DataColumn(label: Text('Action')),
      ],
      rows: [
        DataRow(
          cells: [
            DataCell(const Text('1')),
            DataCell(const Text('T667224344')),
            DataCell(const Text('CD.0016')),
            DataCell(const Text('Kamau Mwangi')),
            DataCell(Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.visibility, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            )),
          ],
        ),
        // Add more rows as needed based on search results
      ],
    );
  }
}
