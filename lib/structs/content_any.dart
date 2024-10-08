// import {
//   AbstractUpdateDecoder,
//   AbstractUpdateEncoder,
//   Transaction,
//   Item,
//   StructStore, // eslint-disable-line
// } from "../internals.js";

import 'package:flutter_crdt/structs/item.dart';
import 'package:flutter_crdt/utils/struct_store.dart';
import 'package:flutter_crdt/utils/transaction.dart';
import 'package:flutter_crdt/utils/update_decoder.dart';
import 'package:flutter_crdt/utils/update_encoder.dart';

class ContentAny implements AbstractContent {
  /**
   * @param {List<any>} arr
   */
  ContentAny(this.arr);
  List<dynamic> arr;

  /**
   * @return {number}
   */
  @override
  int getLength() {
    return this.arr.length;
  }

  /**
   * @return {List<any>}
   */
  @override
  List<dynamic> getContent() {
    return this.arr;
  }

  /**
   * @return {boolean}
   */
  @override
  bool isCountable() {
    return true;
  }

  /**
   * @return {ContentAny}
   */
  @override
  ContentAny copy() {
    return ContentAny(this.arr);
  }

  /**
   * @param {number} offset
   * @return {ContentAny}
   */
  @override
  ContentAny splice(int offset) {
    final right = ContentAny(this.arr.sublist(offset));
    this.arr = this.arr.sublist(0, offset);
    return right;
  }

  /**
   * @param {ContentAny} right
   * @return {boolean}
   */
  @override
  bool mergeWith(AbstractContent right) {
    if (right is ContentAny) {
      this.arr = [...this.arr, ...right.arr];
      return true;
    } else {
      return false;
    }
  }

  /**
   * @param {Transaction} transaction
   * @param {Item} item
   */
  @override
  void integrate(transaction, item) {}
  /**
   * @param {Transaction} transaction
   */
  @override
  void delete(Transaction transaction) {}
  /**
   * @param {StructStore} store
   */
  @override
  void gc(StructStore store) {}
  /**
   * @param {AbstractUpdateEncoder} encoder
   * @param {number} offset
   */
  @override
  void write(AbstractUpdateEncoder encoder, int offset) {
    final len = this.arr.length;
    encoder.writeLen(len - offset);
    for (var i = offset; i < len; i++) {
      final c = this.arr[i];
      encoder.writeAny(c);
    }
  }

  /**
   * @return {number}
   */
  @override
  int getRef() {
    return 8;
  }
}

/**
 * @param {AbstractUpdateDecoder} decoder
 * @return {ContentAny}
 */
ContentAny readContentAny(AbstractUpdateDecoder decoder) {
  final len = decoder.readLen();
  final cs = [];
  for (var i = 0; i < len; i++) {
    cs.add(decoder.readAny());
  }
  return ContentAny(cs);
}
