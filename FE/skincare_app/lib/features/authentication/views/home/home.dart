import 'package:flutter/material.dart';
import 'package:skincare_app/common/widgets/ccard.dart';
import 'package:skincare_app/common/widgets/cproductcard.dart';
import 'package:skincare_app/common/widgets/decorations/clinebetween.dart';
import 'package:skincare_app/common/widgets/text/ctexttitle.dart';
import 'package:skincare_app/features/product/data/product_repo.dart';
import 'package:skincare_app/features/product/models/product.dart';
import 'package:skincare_app/features/routine/data/routine_repo.dart';
import 'package:skincare_app/features/routine/models/routine.dart';
import 'package:skincare_app/features/routine/views/routinepage.dart';
import 'package:skincare_app/features/survey/data/repository/survey_repo.dart';
import 'package:skincare_app/features/survey/models/survey.dart';
import 'package:skincare_app/features/survey/views/testpage.dart';
import 'package:skincare_app/common/widgets/skeletonCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomePage> {
  late List<Survey> surveys;
  late List<Routine> routines;
  int page = 1;
  bool isLoadingProduct = false;
  bool hasMore = true;
  List<Product> products = [];
  bool isLoading = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchSurveys();
    fetchRoutines();
    fetchProducts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        fetchProducts();
      }
    });
  }

  Future<void> fetchSurveys() async {
    setState(() => isLoading = true);
    final data = await SurveyRepository().getAllSurveys();

    setState(() {
      surveys = data;
      isLoading = false;
    });
  }

  Future<void> fetchRoutines() async {
    setState(() => isLoading = true);
    final data = await RoutineRepo().getAll();

    setState(() {
      routines = data;
      isLoading = false;
    });
  }

  Future<void> fetchProducts() async {
    if (isLoadingProduct || !hasMore) return;

    setState(() => isLoadingProduct = true);

    final newProducts = await ProductRepo().getProducts(page);

    setState(() {
      page++;
      isLoadingProduct = false;

      if (newProducts.isEmpty) {
        hasMore = false;
      } else {
        products.addAll(newProducts);
      }
    });
  }

  Future<void> _toggleSave(int index) async {
    try {
      setState(() => isLoading = true);
      final routine = routines[index];
      final isSaved = routine.isSaved;

      bool res = isSaved
          ? await RoutineRepo().unSaveRoutine(routine.id)
          : await RoutineRepo().saveRoutine(routine.id);

      if (!mounted) return;
      if (res) {
        setState(() {
          routines[index].isSaved = !isSaved;
        });
      }
      print('res: ' + res.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            res
                ? (isSaved
                      ? 'Unsave routine successfully!'
                      : 'Save routine successfully!')
                : 'Action failed!',
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

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false, // Turn off icon back
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(10),
        child: Center(
          child: ListView(
            controller: _scrollController,
            children: [
              Column(
                spacing: 10,
                children: [
                  CTextTitle(title: 'Skin Tone'),
                  Text(
                    'Answer the question below to discover your skin - structure, tone and so on...',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 210,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: surveys.length,
                      itemBuilder: (context, index) {
                        return CCard(
                          title: surveys[index].title,
                          subtitle: surveys[index].description,
                          image:
                              'https://cdn5.vectorstock.com/i/1000x1000/86/19/skin-color-palette-level-icon-vector-33818619.jpg',
                          function: () async {
                            print(surveys[index].id);
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TestingPage(surveyId: surveys[index].id),
                              ),
                            );

                            fetchSurveys();
                          },
                          buttonText: surveys[index].isCompleted
                              ? 'See Result'
                              : 'Do Test',
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 10);
                      },
                    ),
                  ),

                  CLineBetween(),

                  // Routine ++
                  CTextTitle(title: 'Suggesting routine'),
                  Text(
                    'Save the routine best suitable for you',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 400,
                    child: ListView.separated(
                      itemCount: routines.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Material(
                          color: Color.fromARGB(255, 253, 249, 243),
                          shape: BeveledRectangleBorder(),
                          child: InkWell(
                            onTap: () {},
                            child: ListTile(
                              leading: Icon(Icons.sunny), // Leading icon
                              title: Text(routines[index].title), // Title text
                              subtitle: Text(
                                routines[index].desc ?? '',
                              ), // Subtitle text
                              trailing: IconButton(
                                onPressed: () => _toggleSave(
                                  index,
                                  // routines[index].id,
                                  // routines[index].isSaved,
                                ),
                                icon: routines[index].isSaved
                                    ? Icon(Icons.bookmark)
                                    : Icon(Icons.bookmark_add_outlined),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RoutinePage(
                                      haveLeading: true,
                                      routineId: routines[index].id,
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
                  CLineBetween(),

                  // Hot Products:
                  CTextTitle(title: 'Hot products'),
                  Text(
                    'Hot products that are recommended for all type of skins, click for more detail',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 0),
                    child: GridView.builder(
                      // controller: _scrollController,
                      padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two columns
                        crossAxisSpacing: 15.0, // Spacing between columns
                        mainAxisSpacing: 15.0, // Spacing between rows
                        childAspectRatio: 1.0, // Aspect ratio of each item
                        mainAxisExtent: 250,
                      ),
                      itemCount:
                          products.length +
                          (isLoadingProduct ? 2 : 0), // Total number of items
                      itemBuilder: (BuildContext context, int index) {
                        if (index < products.length) {
                          final product = products[index];
                          return CProductCard(
                            id: product.id,
                            imageProduct:
                                product.imageUrl ??
                                'https://ordinary.com.vn/wp-content/uploads/2020/09/The-Ordinary-Niacinamide10-Zinc-1.jpg',
                            productName: product.name,
                            productBrand: product.brand ?? 'Skinlab',
                            price: (product.price ?? 0).toString(),
                          );
                        }

                        // Skeleton loading:
                        return SkeletonCard();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
