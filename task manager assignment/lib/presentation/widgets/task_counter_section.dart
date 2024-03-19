import 'package:taskmanager/import_links.dart';

CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
Widget get taskCounterSection {
  return SizedBox(
    height: 110,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: _countByStatusWrapper.listOfTaskByStatusData?.length ?? 0,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return TaskCounterCard(
              title: _countByStatusWrapper.listOfTaskByStatusData![index].sId ??
                  '',
              amount:
                  _countByStatusWrapper.listOfTaskByStatusData![index].sum ??
                      0);
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            width: 8,
          );
        },
      ),
    ),
  );
}
