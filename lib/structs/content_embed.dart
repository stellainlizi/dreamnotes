// import {
//   AbstractUpdateDecoder,
//   AbstractUpdateEncoder,
//   StructStore,
//   Item,
//   Transaction, // eslint-disable-line
// } from "../internals.js";

// import * as error from "lib0/error.js";

import 'package:flutter_crdt/structs/item.dart';
import 'package:flutter_crdt/utils/update_decoder.dart';

/**
 * @private
 */
class ContentEmbed implements AbstractContent {
  /**
   * @param {Object} embed
   */
  ContentEmbed(this.embed);
  final Map<String, dynamic> embed;

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
    return [this.embed];
  }

  /**
   * @return {boolean}
   */
  @override
  isCountable() {
    return true;
  }

  /**
   * @return {ContentEmbed}
   */
  @override
  copy() {
    return ContentEmbed(this.embed);
  }

  /**
   * @param {number} offset
   * @return {ContentEmbed}
   */
  @override
  splice(offset) {
    throw UnimplementedError();
  }

  /**
   * @param {ContentEmbed} right
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
  integrate(transaction, item) {}
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
    encoder.writeJSON(this.embed);
  }

  /**
   * @return {number}
   */
  @override
  getRef() {
    return 5;
  }
}

/**
 * @private
 *
 * @param {AbstractUpdateDecoder} decoder
 * @return {ContentEmbed}
 */
ContentEmbed readContentEmbed(AbstractUpdateDecoder decoder) =>
    ContentEmbed((decoder.readJSON() as Map).map((key, value) => MapEntry(key as String, value)));