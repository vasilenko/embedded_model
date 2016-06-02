require 'spec_helper'
require 'support/models'

RSpec.describe 'Container' do
  let(:department) { Department.create }

  describe 'embedding methods' do
    before do
      Department.embeds_one(:boss, class_name: class_name)
      Department.embeds_many(:employees, class_name: class_name)

      department.boss = {}
      department.employees = [{}, {}]
    end

    context 'when :class_name is not set explicitly' do
      let(:class_name) { nil }

      it 'embeds models with the name inferred from the column name' do
        expect(department.boss).to be_a Boss
        expect(department.employees.map(&:class)).to eq [Employee] * 2
      end
    end

    context 'when :class_name is a String' do
      let(:class_name) { 'Person' }

      it 'embeds models with given name' do
        expect(department.boss).to be_a Person
        expect(department.employees.map(&:class)).to eq [Person] * 2
      end
    end

    context 'when :class_name is a kind of Class' do
      let(:class_name) { Person }

      it 'embeds given models' do
        expect(department.boss).to be_a Person
        expect(department.employees.map(&:class)).to eq [Person] * 2
      end
    end
  end

  describe 'embedded models methods' do
    let(:boss) { Boss.new(name: 'Todd') }
    let(:employees) { [Employee.new(name: 'Andy'), Employee.new(name: 'Jim')] }

    before do
      Department.embeds_one(:boss)
      Department.embeds_many(:employees)
    end

    it 'accepts prepared objects' do
      department.boss = boss
      department.employees = employees

      expect(department.boss).to eq boss
      expect(department.employees).to match_array employees
    end

    it 'automatically builds embedded objects from the user input' do
      department.boss = { 'name' => boss.name }
      department.employees = employees.map { |e| { 'name' => e.name } }

      expect(department.boss).to eq boss
      expect(department.employees).to match_array employees
    end

    it 'automatically builds embedded objects after load' do
      department = Department.create(boss: boss, employees: employees)
      department.reload

      expect(department.boss).to eq boss
      expect(department.employees).to match_array employees
    end

    it "doesn't process nil-values" do
      department.boss = nil
      department.employees = [nil, nil]

      expect(department.boss).to eq nil
      expect(department.employees).to eq [nil, nil]
    end
  end
end
