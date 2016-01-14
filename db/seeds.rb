# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ATTRIBUTE_MAP = [
  { record_type: 'relationship', field: 'subject_csid', key: 'subject', nested_key: 'csid', with: nil, searchable: false },
  { record_type: 'relationship', field: 'subject_type', key: 'subject', nested_key: 'documentType', with: nil, searchable: false },
  { record_type: 'relationship', field: 'subject_uri', key: 'subject', nested_key: 'uri', with: nil, searchable: false },
  { record_type: 'relationship', field: 'object_csid', key: 'object', nested_key: 'csid', with: nil, searchable: false },
  { record_type: 'relationship', field: 'object_type', key: 'object', nested_key: 'documentType', with: nil, searchable: false },
  { record_type: 'relationship', field: 'object_uri', key: 'object', nested_key: 'uri', with: nil, searchable: false },
  { record_type: 'collectionobject', field: 'object_name', key: 'collectionobjects_common', nested_key: 'objectName', with: nil, searchable: true },
  { record_type: 'collectionobject', field: 'object_number', key: 'collectionobjects_common', nested_key: 'objectNumber', with: nil, searchable: true },
  { record_type: 'collectionobject', field: 'responsible_department', key: 'collectionobjects_common', nested_key: 'responsibleDepartment', with: nil, searchable: true },
  { record_type: 'collectionobject', field: 'title', key: 'collectionobjects_common', nested_key: 'title', with: nil, searchable: true },
  { record_type: 'collectionobject', field: 'title_type', key: 'collectionobjects_common', nested_key: 'titleType', with: nil, searchable: true },
  { record_type: 'collectionobject', field: 'display_date', key: 'collectionobjects_common', nested_key: 'dateDisplayDate', with: nil, searchable: false },
  { record_type: 'collectionobject', field: 'brief_description', key: 'collectionobjects_common', nested_key: 'briefDescription', with: nil, searchable: true },
  { record_type: 'collectionobject', field: 'content_persons', key: 'collectionobjects_common', nested_key: 'contentPersons', with: 'contentPerson', searchable: true },
  { record_type: 'collectionobject', field: 'content_concepts', key: 'collectionobjects_common', nested_key: 'contentConcepts', with: 'contentConcept', searchable: true },
  { record_type: 'collectionobject', field: 'physical_description', key: 'collectionobjects_common', nested_key: 'physicalDescription', with: nil, searchable: true }, 
  { record_type: 'collectionobject', field: 'dimension_summary', key: 'collectionobjects_common', nested_key: 'dimensionSummary', with: nil, searchable: true },
  { record_type: 'collectionobject', field: 'material_group', key: 'collectionobjects_common', nested_key: 'materialGroup', with: 'materialName', searchable: true },
  { record_type: 'collectionobject', field: 'technique_group', key: 'collectionobjects_common', nested_key: 'techniqueGroup', with: 'technique', searchable: true },
  { record_type: 'collectionobject', field: 'object_production_organization_group', key: 'collectionobjects_common', nested_key: 'objectProductionOrganizationGroup', with: 'objectProductionOrganization', searchable: true },
  { record_type: 'collectionobject', field: 'object_production_people_group', key: 'collectionobjects_common', nested_key: 'objectProductionPeopleGroup', with: 'objectProductionPeople', searchable: true },
  { record_type: 'collectionobject', field: 'object_production_person_group', key: 'collectionobjects_common', nested_key: 'objectProductionPersonGroup', with: 'objectProductionPerson', searchable: true },
  { record_type: 'collectionobject', field: 'ref_name', key: 'collectionspace_core', nested_key: 'refName', with: nil, searchable: false },
  { record_type: 'collectionobject', field: 'uri', key: 'collectionspace_core', nested_key: 'uri', with: nil, searchable: false },
  { record_type: 'collectionobject', field: 'origin_created_by', key: 'collectionspace_core', nested_key: 'createdBy', with: nil, searchable: true },
  { record_type: 'collectionobject', field: 'origin_created_at', key: 'collectionspace_core', nested_key: 'createdAt', with: nil, searchable: false },
  { record_type: 'collectionobject', field: 'origin_updated_at', key: 'collectionspace_core', nested_key: 'updatedAt', with: nil, searchable: false },
]

ATTRIBUTE_MAP.each do |map|
  if AttributeMap.where(map).empty?
    AttributeMap.create(map)
  end
end
