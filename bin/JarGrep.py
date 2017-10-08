#! /usr/bin/env bash
# coding=utf-8

import binascii
import os
import sys
import zipfile

ZIP_FILE_PATH = '~/.groovy/jsoup-1.9.2.jar'

# --- basic type
# here we assume the endian-ess of class file is big-endian

class u1:
    def __init__(self):
        self.value = None

    def read(self, f):
        self.value = f.read(1)

    def value_in_int(self):
        return int(float.fromhex(binascii.hexlify(self.value)))

    def value_in_str(self):
        return str(self.value_in_int())


class u2:
    def __init__(self):
        self.value = None

    def read(self, f):
        self.value = f.read(2)

    def value_in_int(self):
        return int(float.fromhex(binascii.hexlify(self.value)))

    def value_in_str(self):
        return str(self.value_in_int())


class u4:
    def __init__(self):
        self.value = None

    def read(self, f):
        self.value = f.read(4)

    def value_in_int(self):
        return int(float.fromhex(binascii.hexlify(self.value)))

    def value_in_str(self):
        return str(self.value_in_int())


# ------------------------------------------ constant pool ------------------------------------------

class cp_info:
    def __init__(self):
        self.tag = u1()

    def read(self, f):
        self.tag.read(f)

    def is_class(self):
        if self.tag.value_in_int() == 7:
            return True
        else:
            return False

    def is_field_ref(self):
        if self.tag.value_in_int() == 9:
            return True
        else:
            return False

    def is_method_ref(self):
        if self.tag.value_in_int() == 10:
            return True
        else:
            return False

    def is_interface_method_ref(self):
        if self.tag.value_in_int() == 11:
            return True
        else:
            return False

    def is_string(self):
        if self.tag.value_in_int() == 8:
            return True
        else:
            return False

    def is_integer(self):
        if self.tag.value_in_int() == 3:
            return True
        else:
            return False

    def is_float(self):
        if self.tag.value_in_int() == 4:
            return True
        else:
            return False

    def is_long(self):
        if self.tag.value_in_int() == 5:
            return True
        else:
            return False

    def is_double(self):
        if self.tag.value_in_int() == 6:
            return True
        else:
            return False

    def is_name_and_type(self):
        if self.tag.value_in_int() == 12:
            return True
        else:
            return False

    def is_utf8(self):
        if self.tag.value_in_int() == 1:
            return True
        else:
            return False

    def is_method_handle(self):
        if self.tag.value_in_int() == 15:
            return True
        else:
            return False

    def is_method_type(self):
        if self.tag.value_in_int() == 16:
            return True
        else:
            return False

    def is_invoke_dynamic(self):
        if self.tag.value_in_int() == 18:
            return True
        else:
            return False


class class_info(cp_info):
    def __init__(self, ci=cp_info()):
        cp_info.__init__(self)
        self.tag.value = ci.tag.value
        self.name_index = u2()

    def read_info(self, f):
        self.name_index.read(f)

    def dump(self, output):
        output.append('class_info: name_index == ' + self.name_index.value_in_str())


class field_ref_info(cp_info):
    def __init__(self, ci=cp_info()):
        cp_info.__init__(self)
        self.tag.value = ci.tag.value
        self.class_index = u2()
        self.name_and_type_index = u2()

    def read_info(self, f):
        self.class_index.read(f)
        self.name_and_type_index.read(f)

    def dump(self, output):
        output.append('field_ref_info: class_index == ' + self.class_index.value_in_str())
        output.append('field_ref_info: name_and_type_index == ' + self.name_and_type_index.value_in_str())


class method_ref_info(cp_info):
    def __init__(self, ci=cp_info()):
        cp_info.__init__(self)
        self.tag.value = ci.tag.value
        self.class_index = u2()
        self.name_and_type_index = u2()

    def read_info(self, f):
        self.class_index.read(f)
        self.name_and_type_index.read(f)

    def dump(self, output):
        output.append('method_ref_info: class_index == ' + self.class_index.value_in_str())
        output.append('method_ref_info: name_and_type_index == ' + self.name_and_type_index.value_in_str())


class interface_method_ref_info(cp_info):
    def __init__(self, ci=cp_info()):
        cp_info.__init__(self)
        self.tag.value = ci.tag.value
        self.class_index = u2()
        self.name_and_type_index = u2()

    def read_info(self, f):
        self.class_index.read(f)
        self.name_and_type_index.read(f)

    def dump(self, output):
        output.append('interface_method_ref_info: class_index == ' + self.class_index.value_in_str())
        output.append('interface_method_ref_info: name_and_type_index == ' + self.name_and_type_index.value_in_str())


class string_info(cp_info):
    def __init__(self, ci=cp_info()):
        cp_info.__init__(self)
        self.tag.value = ci.tag.value
        self.string_index = u2()

    def read_info(self, f):
        self.string_index.read(f)

    def dump(self, output):
        output.append('string_info: string_index == ' + self.string_index.value_in_str())


class integer_info(cp_info):
    def __init__(self, ci=cp_info()):
        cp_info.__init__(self)
        self.tag.value = ci.tag.value
        self.bytes = u4()

    def read_info(self, f):
        self.bytes.read(f)

    def dump(self, output):
        output.append('integer_info: bytes == ' + self.bytes.value)


class float_info(cp_info):
    def __init__(self, ci=cp_info()):
        cp_info.__init__(self)
        self.tag.value = ci.tag.value
        self.bytes = u4()

    def read_info(self, f):
        self.bytes.read(f)

    def dump(self, output):
        output.append('float_info: bytes == ' + self.bytes.value)


class long_info(cp_info):
    def __init__(self, ci=cp_info()):
        cp_info.__init__(self)
        self.tag.value = ci.tag.value
        self.high_bytes = u4()
        self.low_bytes = u4()

    def read_info(self, f):
        self.high_bytes.read(f)
        self.low_bytes.read(f)

    def dump(self, output):
        output.append('long_info: high_bytes == ' + self.high_bytes.value)
        output.append('long_info: low_bytes == ' + self.low_bytes.value)


class double_info(cp_info):
    def __init__(self, ci=cp_info()):
        cp_info.__init__(self)
        self.tag.value = ci.tag.value
        self.high_bytes = u4()
        self.low_bytes = u4()

    def read_info(self, f):
        self.high_bytes.read(f)
        self.low_bytes.read(f)

    def dump(self, output):
        output.append('double_info: high_bytes == ' + self.high_bytes.value)
        output.append('double_info: low_bytes == ' + self.low_bytes.value)


class name_and_type_info(cp_info):
    def __init__(self, ci=cp_info()):
        cp_info.__init__(self)
        self.tag.value = ci.tag.value
        self.name_index = u2()
        self.descriptor_index = u2()

    def read_info(self, f):
        self.name_index.read(f)
        self.descriptor_index.read(f)

    def dump(self, output):
        output.append('name_and_type_info: name_index == ' + self.name_index.value_in_str())
        output.append('name_and_type_info: descriptor_index == ' + self.descriptor_index.value_in_str())


class utf8_info(cp_info):
    def __init__(self, ci=cp_info()):
        cp_info.__init__(self)
        self.tag.value = ci.tag.value
        self.length = u2()
        self.bytes = str()

    def read_info(self, f):
        self.length.read(f)
        for i in range(0, self.length.value_in_int()):
            tmp = u1()
            tmp.read(f)
            self.bytes += tmp.value

    def dump(self, output):
        output.append('utf8_info: length == ' + self.length.value_in_str())
        output.append('utf8_info: bytes == ' + self.bytes)


class method_handle_info(cp_info):
    def __init__(self, ci=cp_info()):
        cp_info.__init__(self)
        self.tag.value = ci.tag.value
        self.reference_kind = u1()
        self.reference_index = u2()

    def read_info(self, f):
        self.reference_kind.read(f)
        self.reference_index.read(f)

    def dump(self, output):
        output.append('method_handle_info: reference_kind == ' + self.reference_kind.value_in_str())
        output.append('method_handle_info: reference_index == ' + self.reference_index.value_in_str())


class method_type_info(cp_info):
    def __init__(self, ci=cp_info()):
        cp_info.__init__(self)
        self.tag.value = ci.tag.value
        self.descriptor_index = u2()

    def read_info(self, f):
        self.descriptor_index.read(f)

    def dump(self, output):
        output.append('method_type_info: descriptor_index == ' + self.descriptor_index.value_in_str())


class invoke_dynamic_info(cp_info):
    def __init__(self, ci=cp_info()):
        cp_info.__init__(self)
        self.tag.value = ci.tag.value
        self.bootstrap_method_attr_index = u2()
        self.name_and_type_index = u2()

    def read_info(self, f):
        self.bootstrap_method_attr_index.read(f)
        self.name_and_type_index.read(f)

    def dump(self, output):
        output.append('invoke_dynamic_info: bootstrap_method_attr_index == ' + self.bootstrap_method_attr_index.value_in_str())
        output.append('invoke_dynamic_info: name_and_type_index == ' + self.name_and_type_index.value_in_str())


# ------------------------------------------ divide line ------------------------------------------

class field_access_flags:
    def __init__(self):
        self.value = u2()

    ACC_PUBLIC = 0x0001
    ACC_PRIVATE = 0x0002
    ACC_PROTECTED = 0x0004
    ACC_STATIC = 0x0008
    ACC_FINAL = 0x0010
    ACC_VOLATILE = 0x0040
    ACC_TRANSIENT = 0x0080
    ACC_SYNTHETIC = 0x1000
    ACC_ENUM = 0x4000

    def read(self, f):
        self.value.read(f)


class method_access_flags:
    def __init__(self):
        pass

    ACC_PUBLIC = 0x0001
    ACC_PRIVATE = 0x0002
    ACC_PROTECTED = 0x0004
    ACC_STATIC = 0x0008
    ACC_FINAL = 0x0010
    ACC_SYNCHRONIZED = 0x0020
    ACC_BRIDGE = 0x0040
    ACC_VARARGS = 0x0080
    ACC_NATIVE = 0x0100
    ACC_ABSTRACT = 0x0400
    ACC_STRICT = 0x0800
    ACC_SYNTHETIC = 0x1000


class field_info:
    def __init__(self):
        self.access_flags = u2()
        self.name_index = u2()
        self.descriptor_index = u2()
        self.attributes_count = u2()
        self.attribute_info = []


class method_info:
    def __init__(self):
        self.access_flags = u2()
        self.name_index = u2()
        self.descriptor_index = u2()
        self.attributes_count = u2()
        self.attribute_info = []


# ------------------------------------------ attribute ------------------------------------------

class attribute_info:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()


# ------------------------------------------ constant value attribute ------------------------------------------

class constant_value_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        self.constant_value_index = u2()

    def read(self, f):
        self.attribute_name_index.read(f)
        self.attribute_length.read(f)
        self.constant_value_index.read(f)


# ------------------------------------------ code attribute - -----------------------------------------

class code_exception:
    def __init__(self):
        self.start_pc = u2()
        self.end_pc = u2()
        self.handler_pc = u2()
        self.catch_type = u2()


class code_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        self.max_stack = u2()
        self.max_locals = u2()
        self.code_length = u4()
        # self.code_length长度的u1数组
        self.code = []
        self.exception_table_length = u2()
        self.exception_table = []
        self.attributes_count = u2()
        # attributes_count长度的attribute_info数组
        self.attributes = []


# ------------------------------------------ stack map table attribute ------------------------------------------

class StackMapTable(attribute_info):
    def __init__(self):
        attribute_info.__init__(self)
        self.number_of_entries = u2()
        # stack map frame 数组
        self.entries = []

    def read_info(self, f):
        self.number_of_entries.read(f)
        for i in range(0, self.number_of_entries.value_in_int()):
            break


class stack_map_frame:
    def __init__(self):
        self.frame_type = u1()


class same_frame(stack_map_frame):
    def __init__(self):
        stack_map_frame.__init__(self)


class same_locals_1_stack_item_frame(stack_map_frame):
    def __init__(self):
        stack_map_frame.__init__(self)
        # verification_type_info的长度为1的数组
        self.stack = []


class same_locals_1_stack_item_frame_extended(stack_map_frame):
    def __init__(self):
        stack_map_frame.__init__(self)
        self.offset_delta = u2()
        # verification_type_info的长度为1的数组
        self.stack = []


class chop_frame(stack_map_frame):
    def __init__(self):
        stack_map_frame.__init__(self)
        self.offset_delta = u2()


class same_frame_extended(stack_map_frame):
    def __init__(self):
        stack_map_frame.__init__(self)
        self.offset_delta = u2()

    def read_info(self, f):
        self.offset_delta.read(f)


class append_frame(stack_map_frame):
    def __init__(self):
        stack_map_frame.__init__(self)
        self.offset_delta = u2()
        # frame_type - 251 大小的verification_type_info数组
        self.locals = []

    def read_info(self, f):
        self.offset_delta.read(f)


class full_frame(stack_map_frame):
    def __init__(self):
        stack_map_frame.__init__(self)
        self.offset_delta = u2()
        self.number_of_locals = u2()
        # number_of_locals大小的verification_type_info数组
        self.locals = []
        self.number_of_stack_items = u2()
        # number_of_stack_items大小的verification_type_info数组
        self.stack = []

    def read_info(self, f):
        self.offset_delta.read(f)
        self.number_of_locals.read(f)
        for i in range(0, self.number_of_locals.value_in_int()):
            break

        self.number_of_stack_items.read(f)

        for i in range(0, self.number_of_stack_items.value_in_int()):
            break


# ------------------------------------------ exception attribute ------------------------------------------

class exceptions_class:
    def __init__(self):
        self.inner_class_info_index = u2()
        self.outer_class_info_index = u2()
        self.inner_name_index = u2()
        self.inner_class_access_flags = u2()


class exceptions_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        self.number_of_exceptions = u2()
        # 长度为number_of_exceptions的u2数组
        self.exception_index_table = []
        self.classes = []


# ------------------------------------------ inner classes attribute ------------------------------------------

class inner_classes_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        self.number_of_classes = u2()


# ------------------------------------------ enclosing method attribute ------------------------------------------

class enclosing_method_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        self.class_index = u2()
        self.method_index = u2()


# ------------------------------------------ synthetic attribute ------------------------------------------

class synthetic_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()


# ------------------------------------------ signature attribute ------------------------------------------

class signature_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        self.signature_index = u2()


# ------------------------------------------ source file attribute ------------------------------------------

class source_file_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        self.sourcefile_index = u2()


# ------------------------------------------ source debug extension attribute ------------------------------------------

class source_debug_extension_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        # 长度为attribute_length的u1数组
        self.debug_extension = []


# ------------------------------------------ line number table attribute ------------------------------------------

class line_number:
    def __init__(self):
        self.start_pc = u2()
        self.line_number = u2()


class line_number_table_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        self.line_number_table_length = u2()
        # 长度为line_number_table_length的line_number数组
        self.line_number_table = []


# ------------------------------------------ local variable table attribute ------------------------------------------

class local_variable:
    def __init__(self):
        self.start_pc = u2()
        self.length = u2()
        self.name_index = u2()
        self.descriptor_index = u2()
        self.index = u2()


class local_variable_table_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u2()
        self.local_variable_table_length = u2()
        # 长度为local_variable_table_length的local_variable数组
        self.local_variable_table = []


# ------------------------------------------ local variable type table attribute ---------------------------------------

class local_variable_type:
    def __init__(self):
        self.start_pc = u2()
        self.length = u2()
        self.name_index = u2()
        self.signature_index = u2()
        self.index = u2()


class local_variable_type_table_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        self.local_variable_type_table_length = u2()
        # 长度为local_variable_type_table_length的local_variable_type的数组
        self.local_variable_type_table = []


# ------------------------------------------ deprecated attribute ------------------------------------------

class deprecated_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()


# ------------------------------------------ attribute ------------------------------------------

class constant_value_index:
    def __init__(self):
        self.value = u2();

    def read(self, f):
        self.value.read(f)


class annotation_value:
    def __init__(self):
        self.value = annotation()

    def read(self, f):
        self.value.read(f)


class enum_const_value:
    def __init__(self):
        self.type_name_index = u2()
        self.const_name_index = u2()

    def read(self, f):
        self.type_name_index.read(f)
        self.const_name_index.read(f)


class class_info_index:
    def __init__(self):
        self.value = u2()

    def read(self, f):
        self.value.read(f)


class array_value:
    def __init__(self):
        self.num_values = u2()
        self.values = []  # element_value 数组


class element_value():
    def __init__(self):
        self.tag = u1()
        self.value = None

    def read(self, f):
        self.tag.read(f)
        if self.tag.value_in_int() == 'B' \
                or self.tag.value_in_int() == 'C' \
                or self.tag.value_in_int() == 'D' \
                or self.tag.value_in_int() == 'F' \
                or self.tag.value_in_int() == 'I' \
                or self.tag.value_in_int() == 'J' \
                or self.tag.value_in_int() == 'S' \
                or self.tag.value_in_int() == 'Z' \
                or self.tag.value_in_int() == 's':
            self.value = constant_value_index()
            self.value.read(f)

        if self.tag.value_in_int() == 'e':
            self.value = enum_const_value()
            self.value.read()

        if self.tag.value_in_int() == 'c':
            self.value = class_info_index()
            self.value.read(f)

        if self.tag.value_in_int() == '@':
            self.value = annotation_value()
            self.value.read(f)

        if self.tag.value_in_int() == '[':
            self.value = array_value()
            self.value.read()


class element_value_pair:
    def __init__(self):
        self.element_name_index = u2()
        self.value = element_value()


class annotation:
    def __init__(self):
        self.type_index = u2()
        self.num_element_value_pairs = u2()
        # 长度为num_element_value_pairs的element_value_pair数组
        self.element_value_pairs = []

    def read(self, f):
        self.type_index.read(f)
        self.num_element_value_pairs.read(f)
        for i in range(0, self.num_element_value_pairs.value_in_int()):
            self.element_value_pairs.append()


class runtime_visible_annotation_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        self.num_annotations = u2()
        # 长度为num_annotation的annotation数组
        self.annotations = []

    def read(self, f):
        self.attribute_name_index.read(f)
        self.attribute_length.read(f)
        self.num_annotations.read(f)
        self.annotations = [annotation() for i in range(0, self.num_annotations.value_in_int())]
        for i in range(self.num_annotations.value_in_int()):
            self.annotations[i].read()


# ------------------------------------------ runtime invisible annotation attribute ------------------------------------

class runtime_invisible_annotation_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        self.num_annotations = u2()
        self.annotations = []

    def read(self, f):
        self.attribute_name_index.read(f)
        self.attribute_length.read(f)
        self.num_annotations.read(f)
        self.annotations = [annotation() for i in range(0, self.num_annotations.value_in_int())]
        for i in range(self.num_annotations.value_in_int()):
            self.annotations[i].read()


# ------------------------------------------ runtime visible parameter annotation attribute ----------------------------

class parameter_annotation:
    def __init__(self):
        self.num_annotations = u2()
        self.annotations = []

    def read(self, f):
        self.num_annotations.read(f)
        self.annotations = [annotation() for i in range(0, self.num_annotations.value_in_int())]
        for a in self.annotations:
            a.read(f)


class runtime_visible_parameter_annotation_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        self.num_parameters = u1()
        self.parameter_annotations = []

    def read(self, f):
        self.attribute_name_index.read(f)
        self.attribute_length.read(f)
        self.num_parameters.read(f)
        self.parameter_annotations = [parameter_annotation() for i in range(0, self.num_parameters.value_in_int())]
        for pa in self.parameter_annotations:
            pa.read(f)


# ------------------------------------------ runtime invisible parameter annotation attribute --------------------------

class runtime_invisible_parameter_annotation_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        self.num_parameters = u1()
        self.parameter_annotations = []

    def read(self, f):
        self.attribute_name_index.read(f)
        self.attribute_length.read(f)
        self.num_parameters.read(f)
        self.parameter_annotations = [parameter_annotation() for i in range(self.num_parameters.value_in_int())]
        for pa in self.parameter_annotations:
            pa.read(f)


# ------------------------------------------ runtime visible type annotation attribute ---------------------------------

class type_parameter_target:
    def __init__(self):
        self.type_parameter_index = u1()

    def read(self, f):
        self.type_parameter_index.read(f)


class supertype_target:
    def __init__(self):
        self.supertype_index = u2()

    def read(self, f):
        self.supertype_index.read(f)


class type_parameter_bound_target:
    def __init__(self):
        self.type_parameter_index = u1()
        self.bound_index = u1()

    def read(self, f):
        self.type_parameter_index.read(f)
        self.bound_index.read(f)


class empty_target:
    def __init__(self):
        pass


class formal_parameter_target:
    def __init__(self):
        self.formal_parameter_index = u1()

    def read(self, f):
        self.formal_parameter_index.read(f)


class throws_target:
    def __init__(self):
        self.throws_type_index = u2()

    def read(self, f):
        self.throws_type_index.read(f)


class type_annotation:
    def __init__(self):
        self.target_type = u1()
        # self


class runtime_visible_type_annotations_attribute:
    def __init__(self):
        self.attribute_name_index = u2()
        self.attribute_length = u4()
        self.num_annotations = u1()
        self.annotations = []

    def read(self, f):
        self.attribute_name_index.read(f)
        self.attribute_length.read(f)
        self.num_annotations.read(f)
        self.annotations = [annotation() for i in range(0, self.num_annotations.value_in_int())]
        for pa in self.annotations:
            pa.read(f)


# ------------------------------------------ JavaClassReader ------------------------------------------

class JavaClassReader:
    def __init__(self):
        self.output = []
        self.magic = u4()
        self.minor_version = u2()
        self.major_version = u2()
        self.constant_pool_count = u2()
        self.constant_pool = []
        self.access_flags = u2()
        self.this_class = u2()
        self.super_class = u2()
        self.interfaces_count = u2()
        self.interfaces = [u2()]
        self.fields_count = u2()
        self.fields = [field_info()]
        self.methods_count = u2()
        self.methods = [method_info()]
        self.attributes_count = u2()
        self.attributes = [attribute_info()]

    def read_magic(self, f):
        self.magic.read(f)

    def read_minor_version(self, f):
        self.minor_version.read(f)

    def read_major_version(self, f):
        self.major_version.read(f)

    def read_constant_pool(self, f):
        self.constant_pool_count.read(f)
        self.constant_pool = []
        for i in range(0, self.constant_pool_count.value_in_int() - 1):
            ci = cp_info()
            ci.read(f)
            if ci.is_class():
                ci_e = class_info(ci)
            elif ci.is_field_ref():
                ci_e = field_ref_info(ci)
            elif ci.is_method_ref():
                ci_e = method_ref_info()
            elif ci.is_interface_method_ref():
                ci_e = interface_method_ref_info()
            elif ci.is_string():
                ci_e = string_info()
            elif ci.is_integer():
                ci_e = integer_info()
            elif ci.is_float():
                ci_e = float_info()
            elif ci.is_long():
                ci_e = long_info()
            elif ci.is_double():
                ci_e = double_info()
            elif ci.is_name_and_type():
                ci_e = name_and_type_info()
            elif ci.is_utf8():
                ci_e = utf8_info()
            elif ci.is_method_handle():
                ci_e = method_handle_info()
            elif ci.is_method_type():
                ci_e = method_type_info()
            elif ci.is_invoke_dynamic():
                ci_e = invoke_dynamic_info()

            if ci_e is not None:
                self.output.append("constant_pool_index == " + str(i))
                ci_e.read_info(f)
                ci_e.dump(self.output)

    def read_access_flags(self, f):
        self.access_flags.read(f)

    def read_this_class(self, f):
        self.this_class.read(f)

    def read_super_class(self, f):
        self.super_class.read(f)

    def read_interfaces(self, f):
        pass

    def read_fields(self, f):
        pass

    def read_methods(self, f):
        pass

    def read_attributes(self, f):
        pass

    def read(self, f):
        self.read_magic(f)
        self.read_minor_version(f)
        self.read_major_version(f)
        self.read_constant_pool(f)
        self.read_access_flags(f)
        self.read_this_class(f)
        self.read_super_class(f)
        self.read_interfaces(f)
        self.read_fields(f)
        self.read_methods(f)
        self.read_attributes(f)

    def search(self, content):
        for line in self.output:
            if content in line:
                print line
                return True;
        return False


class ZipFilter:
    def __init__(self):
        pass

    @staticmethod
    def is_what_we_need(name):
        if '.class' in name:
            return True
        return False


def main(argv):
    # jar file to search
    path = argv[0]
    # string to search
    content = argv[1]

    if os.path.exists(path) and os.path.isfile(path):
        f = zipfile.ZipFile(path)
        for member in f.namelist():
            if ZipFilter.is_what_we_need(member):
                member_file = f.open(member)
                reader = JavaClassReader()
                reader.read(member_file)
                if reader.search(content):
                    print member


sys.exit(main(sys.argv))
