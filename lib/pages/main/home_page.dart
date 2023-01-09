part of '../pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ResourceController _resourcec = ResourceController.to;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _getResource();
    });
  }

  Future _getResource() async {
    _resourcec.getResource(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: _buildListResource(context),
          ),
        ],
      ),
    );
  }

  Widget _buildListResource(BuildContext context) {
    return Obx(() {
      if (_resourcec.isLoadingResource.value) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return _resourcec.listResource.value.isEmpty
          ? SizedBox(
              height: 36,
              child: Center(
                child: Text(
                  'There\'s no resources found',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            )
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _resourcec.listResource.value.length,
              itemBuilder: (context, index) => listTileResource(
                  context, _resourcec.listResource.value[index]),
            );
    });
  }

  Widget listTileResource(BuildContext context, ResourceModel resource) =>
      GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.hardEdge,
              child: ColorDetail(resource: resource),
            ),
          );
        },
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Card(
              elevation: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            resource.name.toUpperCase(),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            resource.pantoneValue,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 6,
                      color: Color(
                          int.parse('0xFF${resource.color.substring(1)}')),
                      child: Center(
                        child: Text(resource.color),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
