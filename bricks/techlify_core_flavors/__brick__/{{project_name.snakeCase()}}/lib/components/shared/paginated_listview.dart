import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:{{project_name.snakeCase()}}/presentation/components/common/shared_return_widget.dart';

typedef BuilderWidget<T> = Widget Function(
    BuildContext context, T item, int index);
typedef Fetch = Function(int pageKey);

class PaginatedListView<T> extends StatefulWidget {
  const PaginatedListView(
      {Key? key,
      required this.fetchData,
      this.physics,
      this.emptyMessage,
      required this.itemBuilder,
      this.noMoreItemsMessage,
      this.emptyWidget,
      required this.controller})
      : super(key: key);
  final PagingController<int, T> controller;
  final Fetch fetchData;
  final BuilderWidget<T> itemBuilder;
  final String? emptyMessage;
  final String? noMoreItemsMessage;
  final Widget? emptyWidget;
  final ScrollPhysics? physics;
  @override
  _PaginatedListViewState<T> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  @override
  void initState() {
    super.initState();
    widget.controller.addPageRequestListener((pageKey) async {
      List<T> items = await widget.fetchData(pageKey);
      paginate(items, pageKey);
    });
  }

  void updateList() {
    widget.controller.refresh();
  }

  void paginate(List<T> items, int pageKey, {bool isCache = false}) {
    bool isLastPage = items.length < 25;
    if (!isLastPage) {
      if (isCache) {
        widget.controller.appendPage(items, pageKey);
      }
      final nextPageKey = ++pageKey;
      widget.controller.appendPage(items, nextPageKey);
    } else {
      widget.controller.appendLastPage(items);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, T>(
      shrinkWrap: true,
      physics: widget.physics,
      pagingController: widget.controller,
      builderDelegate: PagedChildBuilderDelegate<T>(
        noMoreItemsIndicatorBuilder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(widget.noMoreItemsMessage ?? 'No More Items...',
                  style: const TextStyle(color: Colors.grey, fontSize: 12))),
        ),
        itemBuilder: (context, item, index) =>
            widget.itemBuilder(context, item, index),
        firstPageErrorIndicatorBuilder: (context) => ReturnWidget(
            type: ReturnWidgetType.error, message: widget.controller.error),
        newPageProgressIndicatorBuilder: (context) =>
            const ReturnWidget(type: ReturnWidgetType.loadingMore),
        firstPageProgressIndicatorBuilder: (context) =>
            const ReturnWidget(type: ReturnWidgetType.loadingFirst),
        animateTransitions: true,
        noItemsFoundIndicatorBuilder: (context) =>
            widget.emptyWidget ??
            ReturnWidget(
              type: ReturnWidgetType.empty,
              message: widget.emptyMessage,
            ),
      ),
    );
  }
}
