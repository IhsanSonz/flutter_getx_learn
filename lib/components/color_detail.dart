part of 'components.dart';

class ColorDetail extends StatelessWidget {
  const ColorDetail({
    Key? key,
    required this.resource,
  }) : super(key: key);

  final ResourceModel resource;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onDoubleTap: () {
                print(resource.color);
              },
              child: Container(
                height: 250,
                color: Color(int.parse('0xFF${resource.color.substring(1)}')),
                child: Center(
                  child: Text(
                    resource.color,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resource.name.toUpperCase(),
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    children: [
                      Text(
                        resource.pantoneValue,
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 225,
          right: 10,
          child: ElevatedButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: resource.color));
              // copied successfully
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            child: const Icon(Icons.copy),
          ),
        ),
      ],
    );
  }
}
