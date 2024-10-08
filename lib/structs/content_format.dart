// import {
//   AbstractType,
//   AbstractUpdateDecoder,
//   AbstractUpdateEncoder,
//   Item,
//   StructStore,
//   Transaction, // eslint-disable-line
// } from "../internals.js";

// import * as error from "lib0/error.js";

import 'package:flutter_crdt/structs/item.dart';
import 'package:flutter_crdt/types/abstract_type.dart';
import 'package:flutter_crdt/utils/update_decoder.dart';

/**
 * @private
 */
class ContentFormat implements AbstractContent {
  /**
   * @param {string} key
   * @param {Object} value
   */
  ContentFormat(this.key, this.value);
  final String key;
  final Object? value;

  /**
   * @return {number}
   */
  @override
  getLength() {
    return 1;
  }

  /**
   * @return {List<any>}
   */
  @override
  getContent() {
    return [];
  }

  /**
   * @return {boolean}
   */
  @override
  isCountable() {
    return false;
  }

  /**
   * @return {ContentFormat}
   */
  @override
  copy() {
    return ContentFormat(this.key, this.value);
  }

  /**
   * @param {number} offset
   * @return {ContentFormat}
   */
  @override
  splice(offset) {
    throw UnimplementedError();
  }

  /**
   * @param {ContentFormat} right
   * @return {boolean}
   */
  @override
  mergeWith(right) {
    return false;
  }

  /**
   * @param {Transaction} transaction
   * @param {Item} item
   */
  @override
  integrate(transaction, item) {
    // @todo searchmarker are currently unsupported for rich text documents
    /** @type {AbstractType<any>} */ (item.parent as AbstractType)
        .innerSearchMarker = null;
  }

  /**
   * @param {Transaction} transaction
   */
  @override
  delete(transaction) {}
  /**
   * @param {StructStore} store
   */
  @override
  gc(store) {}
  /**
   * @param {AbstractUpdateEncoder} encoder
   * @param {number} offset
   */
  @override
  write(encoder, offset) {
    encoder.writeKey(this.key);
    encoder.writeJSON(this.value);
  }

  /**
   * @return {number}
   */
  @override
  getRef() {
    return 6;
  }
}

/**
 * @param {AbstractUpdateDecoder} decoder
 * @return {ContentFormat}
 */
ContentFormat readContentFormat(AbstractUpdateDecoder decoder) =>
    ContentFormat(decoder.readString(), decoder.readJSON());
