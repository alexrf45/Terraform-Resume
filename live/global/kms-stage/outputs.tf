output "kms_arn" {
  value = aws_kms_key.cmk.arn
}

output "kms_key_id" {
  value = aws_kms_key.cmk.key_id
}
