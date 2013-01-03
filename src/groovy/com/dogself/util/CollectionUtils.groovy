package com.dogself.util


class CollectionUtils {

    public static <T>String join(final Collection<T> col, String delimiter) {
        if (col == null || col.isEmpty()){
          return "";
        }
        if(delimiter == null) delimiter = "";
        Iterator<T> iter = col.iterator();
        StringBuffer buffer = new StringBuffer(iter.next().toString());
        while (iter.hasNext()){
          buffer.append(delimiter).append(iter.next().toString());
        }
        return buffer.toString();
    }
}
