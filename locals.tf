locals {
  a_records     = { for a in var.a_records : a["uid"] => a }
  cname_records = { for c in var.cname_records : c["uid"] => c }
  mx_records    = { for mx in var.mx_records : mx["uid"] => mx }
  txt_records   = { for txt in var.txt_records : txt["uid"] => txt }
}
