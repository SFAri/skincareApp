import 'package:flutter/material.dart';
import 'package:skincare_app/features/authentication/data/auth_repository.dart';
import 'package:skincare_app/features/authentication/models/user.dart';
import 'package:skincare_app/features/authentication/models/user_routine.dart';
import 'package:skincare_app/features/routine/data/routine_repo.dart';
import 'package:skincare_app/features/routine/views/routinepage.dart';

class SavedRoutinePage extends StatefulWidget {
  // final bool haveLeading;
  const SavedRoutinePage({super.key});

  @override
  State<SavedRoutinePage> createState() => _SavedRoutinePageState();
}

class _SavedRoutinePageState extends State<SavedRoutinePage> {
  late User user;
  List<UserRoutine> routines = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final data = await AuthRepository().getMe();

    setState(() {
      user = data;
      routines = data.userRoutines!;
      isLoading = false;
    });
  }

  Future<void> _toggleDelete(int index) async {
    try {
      setState(() => isLoading = true);
      final routine = routines[index];

      bool res = await RoutineRepo().unSaveRoutine(routine.routineId);

      if (!mounted) return;
      if (res) {
        // setState(() => fetchUser());
        fetchUser();
        setState(() {});
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            res ? 'Unsave routine successfully!' : 'Action failed!',
          ),
        ),
      );
    } catch (e) {
      print("ERRORRRRRR: " + e.toString());
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error occurred!')));
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
    // setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Routine'),
        automaticallyImplyLeading: false,
      ),
      // floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.add),),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: ListView.separated(
            itemCount: routines.length,
            itemBuilder: (BuildContext context, int index) {
              return Material(
                color: Color.fromARGB(255, 253, 249, 243),
                shape: BeveledRectangleBorder(),
                child: InkWell(
                  onTap: () {
                    print('Tapped on Item ${index + 1}');
                  },
                  child: ListTile(
                    leading: Icon(Icons.sunny), // Leading icon
                    title: Text(routines[index].routine!.title), // Title text
                    subtitle: Text(
                      routines[index].routine!.desc!,
                    ), // Subtitle text
                    trailing: IconButton(
                      onPressed: () => _dialogBuilder(context, index),
                      icon: Icon(Icons.delete),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoutinePage(
                            haveLeading: true,
                            routineId: routines[index].routineId,
                          ),
                        ),
                      );
                    }, // Trailing icon
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.white,
                height: 8,
                thickness: 1,
              ); // A simple horizontal line separator
            },
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, int index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text('Are you sure unsave this routine?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Sure'),
              onPressed: () {
                _toggleDelete(index);
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
