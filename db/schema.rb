# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_02_26_162217) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_data_on_user_id"
  end

  create_table "email_addresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "email_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "primary", default: false, null: false
    t.boolean "verified", default: false, null: false
    t.string "verification_code", default: "", null: false
    t.index ["user_id"], name: "index_email_addresses_on_user_id"
  end

  create_table "passwords", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hint", default: "", null: false
    t.index ["user_id"], name: "index_passwords_on_user_id"
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "primary", default: false, null: false
    t.string "phone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "verified", default: false, null: false
    t.string "nexmo_request_id", default: "", null: false
    t.index ["user_id"], name: "index_phone_numbers_on_user_id"
  end

  create_table "programs", force: :cascade do |t|
    t.bigint "user_id"
    t.text "input"
    t.text "output"
    t.text "error"
    t.text "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: "", null: false
    t.text "prompt", default: "", null: false
    t.index ["user_id"], name: "index_programs_on_user_id"
  end

  create_table "slack_accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "primary", default: false, null: false
    t.boolean "verified", default: false, null: false
    t.jsonb "auth", default: {}, null: false
    t.jsonb "conversations", default: {}, null: false
    t.index ["user_id"], name: "index_slack_accounts_on_user_id"
  end

  create_table "smtp_accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "primary", default: false, null: false
    t.boolean "verified", default: false, null: false
    t.string "address", default: "smtp.gmail.com", null: false
    t.bigint "port", default: 587, null: false
    t.string "user_name", default: "", null: false
    t.string "password", default: "", null: false
    t.string "authentication", default: "plain", null: false
    t.boolean "enable_starttls_auto", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display_name", default: "", null: false
    t.index ["user_id"], name: "index_smtp_accounts_on_user_id"
  end

  create_table "solid_errors", force: :cascade do |t|
    t.text "exception_class", null: false
    t.text "message", null: false
    t.text "severity", null: false
    t.text "source"
    t.datetime "resolved_at"
    t.string "fingerprint", limit: 64, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fingerprint"],
            name: "index_solid_errors_on_fingerprint",
            unique: true
    t.index ["resolved_at"], name: "index_solid_errors_on_resolved_at"
  end

  create_table "solid_errors_occurrences", force: :cascade do |t|
    t.bigint "error_id", null: false
    t.text "backtrace"
    t.json "context"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["error_id"], name: "index_solid_errors_occurrences_on_error_id"
  end

  create_table "solid_queue_blocked_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.string "concurrency_key", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.index %w[concurrency_key priority job_id],
            name: "index_solid_queue_blocked_executions_for_release"
    t.index %w[expires_at concurrency_key],
            name: "index_solid_queue_blocked_executions_for_maintenance"
    t.index ["job_id"],
            name: "index_solid_queue_blocked_executions_on_job_id",
            unique: true
  end

  create_table "solid_queue_claimed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "process_id"
    t.datetime "created_at", null: false
    t.index ["job_id"],
            name: "index_solid_queue_claimed_executions_on_job_id",
            unique: true
    t.index %w[process_id job_id],
            name:
              "index_solid_queue_claimed_executions_on_process_id_and_job_id"
  end

  create_table "solid_queue_failed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.text "error"
    t.datetime "created_at", null: false
    t.index ["job_id"],
            name: "index_solid_queue_failed_executions_on_job_id",
            unique: true
  end

  create_table "solid_queue_jobs", force: :cascade do |t|
    t.string "queue_name", null: false
    t.string "class_name", null: false
    t.text "arguments"
    t.integer "priority", default: 0, null: false
    t.string "active_job_id"
    t.datetime "scheduled_at"
    t.datetime "finished_at"
    t.string "concurrency_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active_job_id"], name: "index_solid_queue_jobs_on_active_job_id"
    t.index ["class_name"], name: "index_solid_queue_jobs_on_class_name"
    t.index ["finished_at"], name: "index_solid_queue_jobs_on_finished_at"
    t.index %w[queue_name finished_at],
            name: "index_solid_queue_jobs_for_filtering"
    t.index %w[scheduled_at finished_at],
            name: "index_solid_queue_jobs_for_alerting"
  end

  create_table "solid_queue_pauses", force: :cascade do |t|
    t.string "queue_name", null: false
    t.datetime "created_at", null: false
    t.index ["queue_name"],
            name: "index_solid_queue_pauses_on_queue_name",
            unique: true
  end

  create_table "solid_queue_processes", force: :cascade do |t|
    t.string "kind", null: false
    t.datetime "last_heartbeat_at", null: false
    t.bigint "supervisor_id"
    t.integer "pid", null: false
    t.string "hostname"
    t.text "metadata"
    t.datetime "created_at", null: false
    t.index ["last_heartbeat_at"],
            name: "index_solid_queue_processes_on_last_heartbeat_at"
    t.index ["supervisor_id"],
            name: "index_solid_queue_processes_on_supervisor_id"
  end

  create_table "solid_queue_ready_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "created_at", null: false
    t.index ["job_id"],
            name: "index_solid_queue_ready_executions_on_job_id",
            unique: true
    t.index %w[priority job_id], name: "index_solid_queue_poll_all"
    t.index %w[queue_name priority job_id],
            name: "index_solid_queue_poll_by_queue"
  end

  create_table "solid_queue_scheduled_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "scheduled_at", null: false
    t.datetime "created_at", null: false
    t.index ["job_id"],
            name: "index_solid_queue_scheduled_executions_on_job_id",
            unique: true
    t.index %w[scheduled_at priority job_id],
            name: "index_solid_queue_dispatch_all"
  end

  create_table "solid_queue_semaphores", force: :cascade do |t|
    t.string "key", null: false
    t.integer "value", default: 1, null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at"], name: "index_solid_queue_semaphores_on_expires_at"
    t.index %w[key value], name: "index_solid_queue_semaphores_on_key_and_value"
    t.index ["key"], name: "index_solid_queue_semaphores_on_key", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "time_zone"
    t.boolean "admin", default: false, null: false
    t.string "name", default: "", null: false
    t.string "location", default: "", null: false
    t.string "city", default: "", null: false
    t.string "street_number", default: "", null: false
    t.string "route", default: "", null: false
    t.string "county", default: "", null: false
    t.string "state", default: "", null: false
    t.string "postal_code", default: "", null: false
    t.string "country", default: "", null: false
    t.string "latitude", default: "", null: false
    t.string "longitude", default: "", null: false
  end

  add_foreign_key "data", "users"
  add_foreign_key "email_addresses", "users"
  add_foreign_key "passwords", "users"
  add_foreign_key "phone_numbers", "users"
  add_foreign_key "programs", "users"
  add_foreign_key "slack_accounts", "users"
  add_foreign_key "smtp_accounts", "users"
  add_foreign_key "solid_errors_occurrences", "solid_errors", column: "error_id"
  add_foreign_key "solid_queue_blocked_executions",
                  "solid_queue_jobs",
                  column: "job_id",
                  on_delete: :cascade
  add_foreign_key "solid_queue_claimed_executions",
                  "solid_queue_jobs",
                  column: "job_id",
                  on_delete: :cascade
  add_foreign_key "solid_queue_failed_executions",
                  "solid_queue_jobs",
                  column: "job_id",
                  on_delete: :cascade
  add_foreign_key "solid_queue_ready_executions",
                  "solid_queue_jobs",
                  column: "job_id",
                  on_delete: :cascade
  add_foreign_key "solid_queue_scheduled_executions",
                  "solid_queue_jobs",
                  column: "job_id",
                  on_delete: :cascade
end
