/// Estado de una fila en la UI.
enum RowState {
  /// Viene de Firestore y no ha sido tocada.
  synced,

  /// Viene de Firestore y el usuario ha editado algún campo.
  dirty,

  /// Marcada para borrar en el próximo guardado.
  pendingDelete,

  /// Creada localmente, aún no existe en Firestore.
  localOnly,
}

/// Representa una fila de la UI (guardada o local).
/// No contiene controllers ni focus nodes — eso vive en el State.
class ItemRow {
  /// ID de Firestore para filas synced/dirty/pendingDelete.
  /// ID temporal ('local_N') para filas localOnly.
  final String id;
  final RowState state;

  const ItemRow({required this.id, required this.state});

  ItemRow copyWith({String? id, RowState? state}) {
    return ItemRow(
      id: id ?? this.id,
      state: state ?? this.state,
    );
  }

  bool get isLocal => state == RowState.localOnly;
  bool get isPendingDelete => state == RowState.pendingDelete;
  bool get isVisible => state != RowState.pendingDelete;
}